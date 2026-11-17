{pkgs, ...}:
{
  users.users.oisin = {
    isNormalUser = true;
    extraGroups = [
      "wheel" 
      "networkmanager"
      "video"
      "input" 
      "audio" 
      "libvirtd"
      "docker"
      "dialout"
      "wireshark"
    ];
    shell = pkgs.zsh;
  };
}
