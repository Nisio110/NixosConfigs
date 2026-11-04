{ pkgs, ... }:
let
  state = "/var/lib/baserow";
  secrets = "${state}/secrets";
  envFile = "${secrets}/database.env";
in
{
  systemd.slices.teto-tasks.description = "Baserow tasks + PostgreSQL";

  systemd.tmpfiles.rules = [
    "d ${state} 0755 root root -"
    "d ${secrets} 0700 root root -"
    "d ${state}/data 0711 root root -"
    # PostgreSQL's entrypoint owns this directory; never reset it on rebuild.
    "d ${state}/postgres 0700 - - -"
  ];

  # Generated on the server, never evaluated into the world-readable Nix store.
  systemd.services.baserow-secrets = {
    requires = [ "systemd-tmpfiles-setup.service" ];
    after = [ "systemd-tmpfiles-setup.service" ];
    path = [ pkgs.openssl pkgs.coreutils ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      UMask = "0077";
      Slice = "teto-tasks.slice";
    };
    script = ''
      if [ ! -f ${envFile} ]; then
        password=$(openssl rand -hex 32)
        printf 'POSTGRES_PASSWORD=%s\nDATABASE_PASSWORD=%s\n' "$password" "$password" > ${envFile}.tmp
        mv ${envFile}.tmp ${envFile}
      fi
      if [ ! -f ${secrets}/admin-password ]; then
        openssl rand -hex 24 > ${secrets}/admin-password.tmp
        # The parent directory is root-only on the host; the mounted file must
        # be readable by Baserow's unprivileged backend user in the container.
        chmod 0444 ${secrets}/admin-password.tmp
        mv ${secrets}/admin-password.tmp ${secrets}/admin-password
      fi
    '';
  };

  systemd.services.docker-network-baserow = {
    requires = [ "docker.service" ];
    after = [ "docker.service" ];
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Slice = "teto-tasks.slice";
    };
    script = ''
      docker network inspect baserow >/dev/null 2>&1 || docker network create baserow
    '';
  };

  virtualisation.oci-containers.containers = {
    baserow-db = {
      # Linux amd64 manifests, pinned rather than tracking mutable tags.
      image = "postgres:15.18-bookworm";
      environment = {
        POSTGRES_DB = "baserow";
        POSTGRES_USER = "baserow";
      };
      environmentFiles = [ envFile ];
      volumes = [ "${state}/postgres:/var/lib/postgresql/data" ];
      log-driver = "journald";
      extraOptions = [ "--network=baserow" "--network-alias=db" "--cgroup-parent=teto-tasks.slice" ];
    };
    baserow = {
      image = "baserow/baserow:2.4.1";
      dependsOn = [ "baserow-db" ];
      ports = [ "127.0.0.1:8787:80" ];
      environment = {
        BASEROW_PUBLIC_URL = "https://todo.tetocorp.ie";
        BASEROW_CADDY_ADDRESSES = ":80";
        DATABASE_HOST = "db";
        DATABASE_PORT = "5432";
        DATABASE_NAME = "baserow";
        DATABASE_USER = "baserow";
        EMAIL_SMTP = "false";
        BASEROW_FILE_UPLOAD_SIZE_LIMIT_MB = "100";
        BASEROW_TRIGGER_SYNC_TEMPLATES_AFTER_MIGRATION = "false";
      };
      environmentFiles = [ envFile ];
      volumes = [
        "${state}/data:/baserow/data"
        "${secrets}/admin-password:/run/baserow/admin-password:ro"
      ];
      log-driver = "journald";
      extraOptions = [ "--network=baserow" "--cgroup-parent=teto-tasks.slice" ];
    };
  };

  systemd.services.docker-baserow-db = {
    requires = [ "baserow-secrets.service" "docker-network-baserow.service" ];
    after = [ "baserow-secrets.service" "docker-network-baserow.service" ];
    serviceConfig.Slice = "teto-tasks.slice";
  };
  systemd.services.docker-baserow = {
    requires = [ "baserow-secrets.service" "docker-network-baserow.service" ];
    after = [ "baserow-secrets.service" "docker-network-baserow.service" ];
    serviceConfig.Slice = "teto-tasks.slice";
  };

}
