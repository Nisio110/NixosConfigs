# Jellyfin media server — Docker container matching the original Fedora compose setup.
# Config lives in-place at /media/fedora/home/oisin/.config/jellyfin.
{ config, pkgs, ... }:
{
  # NVENC passthrough via CDI
  hardware.nvidia-container-toolkit.enable = true;

  virtualisation.oci-containers = {
    backend = "docker";
    containers.jellyfin = {
      image = "jellyfin/jellyfin:10.11.8";
      autoStart = true;
      environment.JELLYFIN_PublishedServerUrl = "http://127.0.0.1:8096";

      ports = [
        "8096:8096/tcp"
        "7359:7359/udp"
      ];

      volumes = [
        "/media/fedora/home/oisin/.config/jellyfin:/config"
        "/var/cache/jellyfin:/cache"

        "/media/fedora/home/oisin/Videos:/media"  # Fedora Videos
        "/media/ssd-aon/Videos:/media2"           # ssd-aon
        "/home/oisin/Videos:/media3"              # NixOS videos
      ];

      extraOptions = [
        "--add-host=host.docker.internal:host-gateway"
        "--device=nvidia.com/gpu=all"
        "--cgroup-parent=teto-media.slice"
      ];
    };
  };


  systemd.services.docker-jellyfin.serviceConfig.Slice = "teto-media.slice";

  sops.secrets.jellyfin_api_key = { };
  sops.templates."jellyfin-auth-header" = {
    mode = "0400";
    content = ''
      Authorization: MediaBrowser Token="${config.sops.placeholder.jellyfin_api_key}"
    '';
  };

  systemd.services."jf-refresh" = {
    after    = [ "docker-jellyfin.service" ];
    wants    = [ "docker-jellyfin.service" ];
    partOf   = [ "teto.slice" ];
    wantedBy = [ "teto.slice" ];
    path     = [ pkgs.curl ];

    serviceConfig = {
      Type             = "oneshot";
      RemainAfterExit  = true;
      Slice            = "teto-media.slice";
    };

    script = ''
      curl -fsS -X POST "http://127.0.0.1:8096/Library/Refresh" \
        --retry 10 --retry-connrefused --retry-delay 3 \
        -H @${config.sops.templates."jellyfin-auth-header".path}
    '';
  };


  systemd.tmpfiles.rules = [
    "d /var/cache/jellyfin 0755 1000 1000 -"
  ];


}
