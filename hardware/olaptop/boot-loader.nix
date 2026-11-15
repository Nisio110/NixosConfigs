{ inputs, config, lib, pkgs, ... }:
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = [
    pkgs.sbctl # For debugging and troubleshooting Secure Boot.
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_7_3;
    initrd.availableKernelModules = [
      "xhci_pci"
      "nvme"
    ];
    initrd.kernelModules = [
      "pinctrl_tigerlake"
    ];
    kernelModules = [
      "kvm-intel"
    ];
    extraModprobeConfig = ''
      softdep soc_button_array pre: pinctrl_intel_platform
    '';
    extraModulePackages = [ ];

    zswap = {
      enable = true;
      compressor = "lzo";
    };

    lanzaboote = {
      enable = false;
      pkiBundle = "/var/lib/sbctl";
      autoGenerateKeys.enable = true;
      autoEnrollKeys.enable = true;
    };

    kernelParams = [
      "rhgb"
      "quiet"
    ];

    loader = {
      efi.canTouchEfiVariables = false;
      systemd-boot = {
        enable = lib.mkForce true;
        edk2-uefi-shell.enable = true;
        windows."windows" = {
          title = "Windows 11";
          efiDeviceHandle = "FS0";
          sortKey = "y_windows";
        };
      };
    };
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
