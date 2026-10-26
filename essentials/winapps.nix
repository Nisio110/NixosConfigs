{ pkgs, ... }:
let
  # Change this to your Linux username.
  username = "oisin";

  home = "/home/${username}";
  dataDir = "/var/lib/winapps";
in
{
  environment.systemPackages = with pkgs; [
    curl dialog freerdp git iproute2 libnotify nmap
  ];

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      dns = [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers.winapps = {
      image = "ghcr.io/dockur/windows:latest";
      autoStart = true;

      environment = {
        VERSION = "11";
        RAM_SIZE = "10G";
        CPU_CORES = "4";
        DISK_SIZE = "100G";

        USERNAME = "Oisin";
        PASSWORD = "changeme";

        HOME = home;
      };

      ports = [
        # Web-based VNC interface
        "127.0.0.1:8006:8006"

        # RDP over TCP and UDP
        "127.0.0.1:3389:3389/tcp"
        "127.0.0.1:3389:3389/udp"
      ];

      capabilities = {
        NET_ADMIN = true;
        NET_RAW = true;
      };

      devices = [
        "/dev/kvm:/dev/kvm"
        "/dev/net/tun:/dev/net/tun"
      ];

      volumes = [
        # Persistent Windows C: drive
        "${dataDir}:/storage"

        # Share Linux home directory with Windows
        "${home}:/shared"

        # OEM scripts and registry modifications
        "/etc/winapps/oem:/oem"
      ];
    };
  };

  # Allow the Windows VM to shut down gracefully.
  systemd.services.docker-WinApps.serviceConfig = {
    TimeoutStopSec = 120;
    Restart = "on-failure";
  };

  # Create persistent directories.
  systemd.tmpfiles.rules = [
    "d ${dataDir} 0755 root root -"
    "d /etc/winapps/oem 0755 root root -"
  ];
}

