{ inputs, pkgs, ... }:
{
  imports = [ inputs.niri-config.nixosModules.niri ];

  programs.niri.enable = true;

  # niri-flake's own niri build asserts libdisplay-info 0.2.0, which nixpkgs
  # removed (only 0.3/0.4 remain), so every rebuild fails at eval. Use the
  # nixpkgs niri (binary-cached, built against nixpkgs' libdisplay-info) until
  # sodiboo/niri-flake adapts; the module pushes this package into the
  # home-manager config validation too.
  programs.niri.package = pkgs.niri;
}
