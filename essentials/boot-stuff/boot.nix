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
    "rhgb"
    "quiet"
  ];

  boot.loader = {
    systemd-boot.enable = lib.mkForce true;
    efi = {
      canTouchEfiVariables = false;
      #efiSysMountPoint = "/boot";
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
    enable = false;
    pkiBundle = "/var/lib/sbctl";
    autoGenerateKeys.enable = true;
    autoEnrollKeys.enable = true;
  };

  # the things i do for this fucking operating system
  system.activationScripts.chainloadSecondBoot = ''
    if ! ${pkgs.efibootmgr}/bin/efibootmgr | grep -q "NixOS (p5)"; then
      ${pkgs.efibootmgr}/bin/efibootmgr --create \
        --disk /dev/nvme0n1 --part 5 \
        --loader '\EFI\systemd\systemd-bootx64.efi' \
        --label "NixOS (p5)"
    fi
  '';
}
