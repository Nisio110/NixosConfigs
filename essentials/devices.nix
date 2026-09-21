{
  # === Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  # ---
  hardware.graphics.enable = true;
  services.printing.enable = true;
  services.libinput.enable = true; # Touchpad support
}
