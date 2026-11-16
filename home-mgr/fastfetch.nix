{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
        padding = {
          top = 1;
          right = 3;
        };
      };
      display.separator = "  ";
      modules = [
        "os"
        "kernel"
        "wm"
        "uptime"
        "packages"
        "memory"
      ];
    };
  };
}
