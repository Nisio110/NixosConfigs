# Jellyfin media server — Docker container matching the original Fedora compose setup.
# Config lives in-place at /media/fedora/home/oisin/.config/jellyfin.
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
        "--cgroup-parent=homeserver-media.slice"
      ];
    };
  };

  systemd.services.docker-jellyfin.serviceConfig.Slice = "homeserver-media.slice";

  systemd.tmpfiles.rules = [
    "d /var/cache/jellyfin 0755 1000 1000 -"
  ];


}
