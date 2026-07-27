{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = false;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  services.openssh.enable = true;
}
