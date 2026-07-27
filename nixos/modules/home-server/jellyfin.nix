# Jellyfin media server — Docker container matching the original Fedora compose setup.
# Config lives in-place at /media/fedora/home/oisin/.config/jellyfin.
{
  # Docker engine
  virtualisation.docker.enable = true;

  # NVENC passthrough via CDI (RTX 3060)
  hardware.nvidia-container-toolkit.enable = true;

  virtualisation.oci-containers = {
    backend = "docker";
    containers.jellyfin = {
      image = "jellyfin/jellyfin:10.11.8";
      autoStart = true;
      user = "1000:1000";

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

      environment = {
        JELLYFIN_PublishedServerUrl = "http://127.0.0.1:8096";
      };

      extraOptions = [
        "--add-host=host.docker.internal:host-gateway"
        "--device=nvidia.com/gpu=all"
      ];
    };
  };

  # Ensure the cache directory exists with correct ownership
  systemd.tmpfiles.rules = [
    "d /var/cache/jellyfin 0755 1000 1000 -"
  ];
}
