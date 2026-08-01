{ ... }:
let
  p = import ./_palette.nix;
in
{
  # Spawned by niri (see niri.nix); this only supplies the config file.
  services.mako = {
    enable = true;

    settings = {
      font = "Overpass 11";
      anchor = "top-right";
      layer = "overlay";
      # Clears the floating waybar (34px + 8px margin) plus a gap.
      margin = "12";
      outer-margin = "12,12,12,12";
      padding = "12,16";
      width = 380;
      height = 160;
      border-size = 1;
      border-radius = 12;
      icon-border-radius = 8;
      max-icon-size = 48;
      default-timeout = 6000;
      ignore-timeout = false;
      markup = true;
      actions = true;
      group-by = "app-name";
      max-visible = 5;
      format = "<b>%s</b>\\n%b";

      background-color = "${p.crust}f2";
      text-color = p.text;
      border-color = p.surface1;
      progress-color = "over ${p.surface2}";

      "urgency=low" = {
        border-color = p.surface1;
        text-color = p.subtle;
        default-timeout = 4000;
      };

      "urgency=normal" = {
        border-color = p.green;
      };

      "urgency=critical" = {
        border-color = p.red;
        text-color = p.text;
        default-timeout = 0;
      };

      # Keep the group count that mako's default grouped format provides.
      "grouped" = {
        format = "(%g) <b>%s</b>\\n%b";
      };

      "mode=do-not-disturb" = {
        invisible = 1;
      };
    };
  };
}
