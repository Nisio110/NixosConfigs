{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono-Regular";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 10;
    };

    settings = {
      # Font ligatures
      disable_ligatures = "never";

      # Cursor
      cursor_beam_thickness = 2.0;

      # Scrollback
      scrollback_lines = 5000;

      # Window
      remember_window_size = true;
      initial_window_width = 1121;
      initial_window_height = 656;
      draw_minimal_borders = false;
      window_padding_width = "10 15";
      confirm_os_window_close = 0;

      # Tab bar
      # Your original kitty.conf sets tab_bar_style twice (powerline, then
      # hidden a few lines later). In kitty the later one wins, so the bar
      # was actually hidden. If that wasn't intentional, change to "powerline".
      tab_bar_style = "hidden";
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_powerline_style = "round";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

      # Linux/Wayland
      linux_display_server = "wayland";

      # Remote control
      allow_remote_control = true;
      listen_on = "unix:/tmp/mykitty";
    };

    # Custom theme — not in pkgs.kitty-themes, so themeFile won't work.
    # We ship the .conf via xdg.configFile below and include it from here.
    # The path is relative to the generated kitty.conf.
    extraConfig = ''
      include themes/evergarden-fall-green.conf
      auto_reload_config -1
    '';
  };

  # Place evergarden-fall-green.conf next to this .nix file (or adjust the
  # path) and it will be linked into ~/.config/kitty/themes/.
  xdg.configFile."kitty/themes/evergarden-fall-green.conf".source =
    ./evergarden-fall-green.conf;
}
