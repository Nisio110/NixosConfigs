{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-12-13th-gen-intel
  ];

  hardware.sensor.iio.enable = true;
  hardware.framework.enableKmod = true;

  environment.systemPackages = with pkgs; [
    kdePackages.plasma-keyboard
  ];

  services.fwupd.enable = true;
}
