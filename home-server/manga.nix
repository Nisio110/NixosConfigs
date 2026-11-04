{pkgs, homeDir, user, ...}: 
let 
  dataDir = "/var/lib/suwayomi-server";
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
    inherit dataDir;
    
    settings.server = {
      ip = "127.0.0.1";
      port = 9090;
      extensionStores = [
       "https://github.com/keiyoushi/extensions"
       "https://raw.githubusercontent.com/FelipeGFA/extensoes"
      ];
      flareSolverrEnabled = true;
      flareSolverrUrl = "https://cloudflare-bypass.tetocorp.ie";
    };
  };

  systemd.services = {
    suwayomi-server = {
      serviceConfig.Slice = "teto-manga.slice";
    };

    docker-flaresolverr = {
      serviceConfig.Slice = "teto-manga.slice";
    };
  };
  virtualisation.oci-containers.containers.flaresolverr = {
    image = "ghcr.io/flaresolverr/flaresolverr:latest";
    autoStart = true;
    user = "1000:1000";
    ports = [ "9009:8191" ];
    volumes = [ "/var/lib/flaresolverr:/config" ];
    environment = {
      TZ = "Europe/London";
    };
    extraOptions = [ "--cgroup-parent=teto-manga.slice" ];
  };

}
