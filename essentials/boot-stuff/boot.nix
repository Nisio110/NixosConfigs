# boot.nix
{
  pkgs,
  lib,
  ...
}: let
  sources = import ./_secure-boot/lon.nix;
  lanzaboote = import sources.lanzaboote {
    inherit pkgs;
  };
in {
  imports = [lanzaboote.nixosModules.lanzaboote];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "video=DP-2:2560x1440@165,rotate=270"
    "video=DP-3:2560x1440@200,rotate=0"
    "rhgb"
    "quiet"
  ];

  boot.loader = {
    systemd-boot.enable = lib.mkForce false;
    efi = {
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot/efi";
    };
  };

  environment.systemPackages = [
    pkgs.sbctl # For debugging and troubleshooting Secure Boot.
  ];

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    autoGenerateKeys.enable = true;
    autoEnrollKeys.enable = true;
  };
}
