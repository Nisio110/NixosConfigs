# Evergarden "fall green" — the same palette kitty (evergarden-fall-green.conf)
# and nixvim already use. Single source of truth for the niri session shell.
#
# The leading underscore keeps import-tree from treating this as a module.
{
  crust = "#171c1f"; # darkest — backdrop, bar/menu background
  base = "#232a2e"; # workspace background
  surface0 = "#2b3337"; # raised surface
  surface1 = "#343f44"; # hover / inactive decoration
  surface2 = "#374145"; # selection
  muted = "#6f8788"; # disabled text
  subtle = "#96b4aa"; # secondary text
  text = "#f8f9e8"; # primary text

  green = "#cbe3b3"; # accent
  aqua = "#b3e3ca";
  blue = "#b2caed";
  yellow = "#f5d098";
  red = "#f57f82";
  purple = "#f3c0e5";
}
