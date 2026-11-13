{ pkgs, config, lib, inputs, ... }: 
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  environment.systemPackages = [ pkgs.sbctl ]; # For debugging

  boot = {
    initrd = { 
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
      kernelModules = [];
    };

    kernelModules = ["kvm-amd"];

    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "video=DP-2:2560x1440@165,rotate=270"
      "video=DP-3:2560x1440@200,rotate=0"
      "rhgb"
      "quiet"
    ];

    loader = {
      systemd-boot.enable = lib.mkForce false; # Lanzaboote creates & signs its own systemd-boot install
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };


    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      autoGenerateKeys.enable = true;
      autoEnrollKeys.enable = true;
    };
  };


  # the things i do for this fucking operating system
  system.activationScripts.chainloadSecondBoot = ''
    if ! ${pkgs.efibootmgr}/bin/efibootmgr | grep -q "NixOS (p5)"; then
      ${pkgs.efibootmgr}/bin/efibootmgr --create \
        --disk /dev/nvme0n1 --part 5 \
        --loader '\EFI\systemd\systemd-bootx64.efi' \
        --label "SystemD-Boot"
    fi
  '';
}
