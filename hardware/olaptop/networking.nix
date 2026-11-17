{ user, hostname, ... }:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    wireless.userControlled = true;
    
    # attempt to add eduroam to trusted
    # networks for a comm3005 lab
    nftables.enable = true;
    firewall.extraInputRules = ''
      ip saddr 10.156.25.0/24 accept
    '';
  };

  services = {
    netbird.enable = true;
    tailscale.enable = false;
    openssh.enable = true;
  };

  services.tailscale.extraSetFlags = [ "--operator=${user}" ];
}
