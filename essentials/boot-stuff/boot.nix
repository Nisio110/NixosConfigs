# boot.nix
{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "video=DP-2:2560x1440@165,rotate=270"
    "video=DP-3:2560x1440@200,rotate=0"
    "rhgb"
    "quiet"
  ];

  boot.loader = {
    systemd-boot.enable = lib.mkForce false; # Lanzaboote creates & signs its own systemd-boot install
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  environment.systemPackages = [ pkgs.sbctl ]; # For debugging

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    autoGenerateKeys.enable = true;
    autoEnrollKeys.enable = true;
  };
}
