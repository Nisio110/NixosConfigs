{ pkgs, ... }:
{
  # === NVIDIA Kernel Drivers
  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    nvidia = {
      open = false;
      branch = "production";
      nvidiaSettings = true;
      modesetting.enable = true;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  environment.systemPackages = with pkgs; [
    nvidia-system-monitor-qt
    btop-cuda
  ];
}
