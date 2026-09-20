{user, hostname, ...}:
{
  networking = {
    hostName = hostname;

    nameservers = [ "192.168.0.1" "127.0.0.1" "1.1.1.1" ];

    networkmanager.enable = true;

    firewall.enable = false;
    
    defaultGateway = {
      address = "192.168.0.1";
      interface = "eno1";
    };

    interfaces."eno1" = {
      useDHCP = false;

      macAddress = "B4:2E:99:F2:5F:29";

      ipv4.addresses = [
        { address = "192.168.0.19"; prefixLength = 24; }
        { address = "192.168.0.20"; prefixLength = 24; } # sunshine
      ];

      wakeOnLan.enable = true;
      wakeOnLan.policy = ["magic"];
    };

  };

  services = {
    netbird.enable = true;
    tailscale.enable = false;
    openssh.enable = true;
  };

  services.tailscale.extraSetFlags = [ "--operator=${user}" ];
}
