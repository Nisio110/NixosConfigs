let
  p = import ./_palette.nix;

  # fuzzel wants RRGGBBAA without a leading '#'.
  rgba = hex: alpha: (builtins.substring 1 6 hex) + alpha;
in
{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = "Overpass Nerd Font:size=12";
        # Quoted so fuzzel keeps the trailing space after the glyph.
        prompt = ''"󰍉  "'';
        placeholder = "Search";
        terminal = "kitty";
        layer = "overlay";
        # breeze-dark ships with the Plasma session that's also installed.
        icon-theme = "breeze-dark";
        icons-enabled = true;
        lines = 12;
        width = 42;
        tabs = 4;
        horizontal-pad = 20;
        vertical-pad = 16;
        inner-pad = 8;
        line-height = 24;
        image-size-ratio = 0.4;
        exit-on-keyboard-focus-loss = true;
        match-counter = true;
      };

      colors = {
        background = rgba p.crust "f2";
        text = rgba p.subtle "ff";
        prompt = rgba p.green "ff";
        placeholder = rgba p.muted "ff";
        input = rgba p.text "ff";
        match = rgba p.green "ff";
        selection = rgba p.surface2 "ff";
        selection-text = rgba p.text "ff";
        selection-match = rgba p.green "ff";
        counter = rgba p.muted "ff";
        border = rgba p.surface1 "ff";
      };

      border = {
        width = 1;
        radius = 12;
        selection-radius = 8;
      };
    };
  };
}
