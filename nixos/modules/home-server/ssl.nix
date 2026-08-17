{pkgs, user, ...}:{
  environment.systemPackages = [pkgs.openssl];

  systemd.tmpfiles.rules = [
    "d /var/lib/ssl/    0750 nginx nginx -"
    "d /var/lib/ssl/ca/ 0711 root  root  -"
  ];

  # Root CA cert (public, committed to the repo) — copied from
  # /var/lib/ssl/ca/ca.crt after tetocorp-ca-init first generated it.
  # Stable for the CA's 10-year lifetime, so this only needs updating if
  # the CA itself is ever rotated.
  security.pki.certificateFiles = [ ./tetocorp-ca.crt ];

  home-manager.users.${user}.programs.zen-browser.policies.Certificates.Install =
    [ ./tetocorp-ca.crt ];

  # Runs exactly once, ever: the CA must stay stable so client trust
  # doesn't break every time the leaf cert rotates.
  systemd.services."tetocorp-ca-init" = {
    description = "One-time root CA for tetocorp.ie";
    wantedBy    = [ "multi-user.target" ];
    before      = [ "tetocorp-ssl.service" ];
    path        = [ pkgs.openssl ];

    unitConfig = {
      ConditionPathExists = "!/var/lib/ssl/ca/ca.key";
    };

    serviceConfig = {
      Type             = "oneshot";
      RemainAfterExit  = true;
      Slice            = "teto-infra.slice";
    };

    script = ''
      openssl genrsa \
        -out /var/lib/ssl/ca/ca.key 4096

      openssl req -x509 -new \
        -key /var/lib/ssl/ca/ca.key \
        -out /var/lib/ssl/ca/ca.crt \
        -days 3650 \
        -subj \
      "/C=IE"\
      "/ST=Dublin"\
      "/O=tetocorp"\
      "/CN=tetocorp Root CA"\
        -addext "basicConstraints=critical,CA:TRUE" \
        -addext "keyUsage=critical,keyCertSign,cRLSign"
    '';
  };

  # Rotates the leaf cert every 3 days, signed by our own CA. Runs as
  # root (needs to read ca.key), then hands the result to nginx via chown.
  systemd.services."tetocorp-ssl" = {
    after    = [ "NetworkManager.service" "tetocorp-ca-init.service" ];
    wants    = [ "tetocorp-ca-init.service" ];
    partOf   = [ "teto.slice" ];
    wantedBy = [ "teto.slice" ];
    path     = [ pkgs.openssl pkgs.coreutils ];

    serviceConfig = {
      Type  = "oneshot";
      Slice = "teto-infra.slice";
    };

    script = ''
      # Private key
      openssl genrsa \
        -out /var/lib/ssl/tetocorp.key 4096

      # CSR file
      # Provides info embedded into the key
      openssl req -new \
        -key /var/lib/ssl/tetocorp.key \
        -out /var/lib/ssl/tetocorp.csr \
        \
        -subj \
      "/C=IE"\
      "/ST=Dublin"\
      "/O=tetocorp"\
      "/CN=tetocorp.ie"\
        \
        -addext "subjectAltName="\
      "DNS:www.tetocorp.ie,"\
      "DNS:tetocorp.ie,"\
      "DNS:watch.tetocorp.ie,"\
      "DNS:browse.tetocorp.ie,"\
      "DNS:vpn.tetocorp.ie,"\
      "DNS:notes.tetocorp.ie,"\
      "DNS:manga.tetocorp.ie,"\
      "DNS:cloudflare-bypass.tetocorp.ie,"\
      "DNS:print.tetocorp.ie,"\
      "DNS:stream.tetocorp.ie,"\
      "IP:192.168.0.19"

      # SSL Cert — signed by our own CA, not self-signed
      # -req             : treat input as csr instead of a crt
      # -days 3          : valid for n days
      # -copy_extensions : without this, subjectAltName from the CSR is
      #                    silently dropped from the issued certificate
      openssl x509 \
        -req \
        -days 3 \
        -in /var/lib/ssl/tetocorp.csr \
        -CA /var/lib/ssl/ca/ca.crt \
        -CAkey /var/lib/ssl/ca/ca.key \
        -CAcreateserial \
        -copy_extensions copy \
        -out /var/lib/ssl/tetocorp.crt

      chown nginx:nginx \
        /var/lib/ssl/tetocorp.key \
        /var/lib/ssl/tetocorp.csr \
        /var/lib/ssl/tetocorp.crt
    '';
  };

  # -days 3 means the leaf cert must be re-signed on that cadence;
  # Type=oneshot has no restart behavior of its own, so a timer drives it.
  systemd.timers."tetocorp-ssl" = {
    description = "Rotate tetocorp.ie leaf certificate every 3 days";
    wantedBy    = [ "timers.target" ];
    timerConfig = {
      OnBootSec       = "1min";
      OnUnitActiveSec = "3d";
      Persistent      = true;
    };
  };
}
