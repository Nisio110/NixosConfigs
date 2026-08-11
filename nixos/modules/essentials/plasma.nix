{pkgs, inputs, lib, ...}: 
let 
  kdePackages = with pkgs.kdePackages; [
    kcalc
    kcharselect
    kclock
    kcolorchooser
    kolourpaint
    ksystemlog
    sddm-kcm
    xdg-desktop-portal-kde
    isoimagewriter
    partitionmanager
  ];
  
  miscPackages = with pkgs; [
      bibata-cursors
      kdiff3
      hardinfo2
      wayland-utils
      wl-clipboard
      (catppuccin-sddm.override {
        flavor = "mocha";
        accent = "mauve";
      })
  ];

  plasmaPkgs = miscPackages ++ kdePackages;
in {
  environment.systemPackages = plasmaPkgs;
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.autoLogin.enable = true;
  };
  programs = {
    kdeconnect.enable = true;
  };

  services.displayManager = {
    autoLogin.user = "oisin";
    sddm.wayland.enable = true;
    sddm.wayland.compositor = "kwin";
  };

  # Copies Plasma display config to SDDM
  # This fixes issues with display rotation
  system.activationScripts.sddmDisplayConfig.text =
  ''
    if [ -f /home/oisin/.config/kwinoutputconfig.json ]; then
      mkdir -p /var/lib/sddm/.config
      cp /home/oisin/.config/kwinoutputconfig.json /var/lib/sddm/.config/
      chown sddm:sddm /var/lib/sddm/.config/kwinoutputconfig.json
    fi
  '';
}
