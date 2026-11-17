{ pkgs, user, hostname, ... }:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    wireless.userControlled = true;
    

  };

  # attempt to add eduroam to trusted
  # networks for a comm3005 lab
  # firewall.enable = false;
  networking.nftables.enable = true;
  networking.firewall.enable = true;
  networking.firewall.extraInputRules = ''
    ip saddr 10.74.239.0/24 accept
  #'';
  services.firewalld.enable = true;
  environment.systemPackages = [pkgs.firewalld-gui];
  # =======

  services = {
    netbird.enable = true;
    tailscale.enable = false;
    openssh.enable = true;
  };

  services.tailscale.extraSetFlags = [ "--operator=${user}" ];
}
