{ pkgs, inputs, ... }:
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.plasma = let 
      wallpaper = "/home/oisin/.local/share/wallpapers/macos-space/macos-space-1.jpg";
    in {
    enable = true;

    fonts = {
      general = { family = "Overpass"; pointSize = 10; };
      fixedWidth = { family = "Overpass Mono"; pointSize = 10; };
    };
    
    workspace = {
      cursor = { theme = "Bibata-Modern-Ice"; size = 24; };
      inherit wallpaper;
    };

    kscreenlocker = {
      appearance.wallpaper = wallpaper;
      autoLock = true;
      timeout = 120; # minutes
    };

    krunner = {
      position = "top";
      historyBehavior = "enableAutoComplete";
    };
  };
}
