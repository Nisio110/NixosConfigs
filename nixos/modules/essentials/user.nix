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
    ];
    shell = pkgs.zsh;
  };
}
