{ modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1fabf90e-0ebe-448e-a6d7-20c3d2ff544d";
    fsType = "btrfs";
    options = [ "subvol=root" "compress=zstd" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/1fabf90e-0ebe-448e-a6d7-20c3d2ff544d";
    fsType = "btrfs";
    options = [ "subvol=home" "compress=zstd" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/1fabf90e-0ebe-448e-a6d7-20c3d2ff544d";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd" "noatime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2FDD-8D98";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  #fileSystems."/media/windows" = { device = "/dev/disk/by-uuid/e3e6e93e-9c2e-4e23-aec4-bc0019dd628"; fsType = "ntfs-3g"; };

  swapDevices = [{
    device = "/swap/swapfile";
    size = 8 * 1024; # 8 GiB
  }];

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
}
