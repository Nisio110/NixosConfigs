{user, hostname, ...}:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    wireless.userControlled = true;
  };

  services = {
    netbird.enable = true;
    tailscale.enable = false;
    openssh.enable = true;
  };

  services.tailscale.extraSetFlags = [ "--operator=${user}" ];
}
