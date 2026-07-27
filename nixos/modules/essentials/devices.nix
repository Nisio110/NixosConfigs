{
  # === Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  # ---

  services.printing.enable = true;
  services.libinput.enable = true; # Touchpad support
}
