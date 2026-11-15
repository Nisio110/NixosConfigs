{ inputs, pkgs, ... }:
{
  imports = [ inputs.niri-config.nixosModules.niri ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;
}
