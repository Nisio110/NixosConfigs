{user, ...}:
{
  networking = {
    hostName = "hdesktop";
    networkmanager.enable = true;
    firewall.enable = false;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
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
