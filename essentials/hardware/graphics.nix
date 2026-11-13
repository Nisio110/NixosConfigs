{ pkgs, ... }:
{
  # === NVIDIA Kernel Drivers
  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    nvidia = {
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;
    };
  };
  services.xserver.videoDrivers = ["nvidia"];
}
