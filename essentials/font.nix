{pkgs, ...}:
{
  fonts.packages = with pkgs; [
    overpass
    nerd-fonts.overpass
  ];
}
