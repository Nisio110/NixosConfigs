{pkgs, homeDir, user, ...}:
let 
  dataDir = "/var/lib/suwayomi-server";
  localSourcePath = "${dataDir}/sources";
in {
  nixpkgs.overlays = [
    (final: prev: let version = "2.4.2366"; in {
        suwayomi-server = prev.suwayomi-server.overrideAttrs {
          inherit version;
          src = final.fetchurl {
            url = "https://github.com/Suwayomi/Suwayomi-Server/releases/download/v${version}/Suwayomi-Server-v${version}.jar";
            hash = "sha256-r5/rIK+dfr6eMHaebG68f8erHERziNQuAoCx2l/ge/0=";
          };
        };
      })
  ];

  services.suwayomi-server = {
    enable = true;

    user = "oisin";
    group = "users";
    inherit dataDir;

    settings.server = {
      ip = "127.0.0.1";
      port = 9090;
      inherit localSourcePath;
      extensionRepos = [
       "https://github.com/keiyoushi/extensions"
       "https://raw.githubusercontent.com/FelipeGFA/extensoes"
      ];
      flareSolverrEnabled = true;
      flareSolverrUrl = "https://cloudflare-bypass.tetocorp.ie";
    };
  };

  systemd.tmpfiles.rules = [
    "d  0755 ${user} users - ${localSourcePath}"
  ];
  systemd.services.suwayomi-server.serviceConfig.Slice = "teto-manga.slice";
  systemd.services.docker-flaresolverr.serviceConfig.Slice = "teto-manga.slice";

  virtualisation.oci-containers.containers.flaresolverr = {
    image = "ghcr.io/flaresolverr/flaresolverr:latest";
    autoStart = true;
    user = "1000:1000";
    ports = [ "9009:8191" ];
    volumes = [ "/var/lib/flaresolver:/config" ];
    environment = {
      TZ = "Europe/London";
    };
    extraOptions = [ "--cgroup-parent=teto-manga.slice" ];
  };

}
