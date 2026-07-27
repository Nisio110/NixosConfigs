{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd = { 
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/e4278887-3c03-469f-9243-9bb6502f595f";
      fsType = "ext4";
    };

    "/boot/efi" = {
      device = "/dev/disk/by-uuid/7563-2E50";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/aa47fa61-a391-4aea-b182-c119f1c720dc";
      fsType = "ext4";
    };

    "/media/fedora" = {
      device = "/dev/disk/by-uuid/94c81553-db14-4adf-9c28-f0b4948487e6";
      fsType = "btrfs";
    };

    "/media/ssd-aon" = {
      device = "/dev/disk/by-uuid/1709c0d4-74a9-4c03-8aae-e9991948a6f8";
      fsType = "btrfs";
    };

    "/media/windows" = {
      device = "/dev/disk/by-uuid/F49A11179A10D846";
      fsType = "ntfs";
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/2601a03e-d86d-490f-8838-0cf1da96f8c3";}
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # === NVIDIA Kernel Drivers
  hardware = {
    graphics.enable = true;
    nvidia = {
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;
    };
  };
  services.xserver.videoDrivers = ["nvidia"];
  # ---

  # === Disable Sleep
  # Sleep is broken on my motherboard
  systemd.sleep.settings.Sleep = {
    AllowSuspend = "no";
    AllowHibernation = "no";
    AllowSuspendThenHibernate = "no";
    AllowHybridSleep = "no";
  };
  # ---
}

