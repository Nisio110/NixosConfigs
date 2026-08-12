{user, ...}:
{
  networking = {
    hostName = "hdesktop";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" ];

    firewall.enable = false;
    interfaces."eno1".ipv4.addresses = [
      {
        address = "192.168.0.19";
        prefixLength = 24;
      }
    ];
  };

  services = {
    netbird.enable = true;
    tailscale.enable = false;
    openssh.enable = true;
  };

  services.tailscale = {
    extraSetFlags = [ "--operator=${user}" ];
  };
}
