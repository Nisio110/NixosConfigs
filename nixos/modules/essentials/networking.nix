{user, ...}:
{
  networking = {
    hostName = "hdesktop";
    nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" ];
    defaultGateway = {
      address = "192.168.0.1";
    };
    networkmanager.enable = true;

    firewall.enable = false;
    
    interfaces."eno1" = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "192.168.0.19";
          prefixLength = 24;
        }
      ];
    };
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
