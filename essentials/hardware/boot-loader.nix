{ pkgs, config, lib, inputs, ... }: 
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot = {
    initrd = { 
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd"];
  };

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

  systemd.services.ensure-nixos-efi-entry = {
    description = "Ensure NixOS Lanzaboote-signed systemd-boot EFI entry exists";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];

    unitConfig.ConditionPathExists = "/sys/firmware/efi/efivars";

    path = [
      pkgs.efibootmgr
      pkgs.gnugrep
    ];

    serviceConfig.Type = "oneshot";

    script = ''
      if ! efibootmgr -v \
        | grep -Fq '\EFI\systemd\systemd-bootx64.efi'
      then
        efibootmgr \
          --create \
          --disk /dev/nvme0n1 \
          --part 5 \
          --label "SystemD-Boot" \
          --loader '\EFI\systemd\systemd-bootx64.efi'
      fi
    '';
  };
}
