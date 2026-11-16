{ pkgs, ... }:

let
  customPlugins = import ../_pkgs.nix { inherit pkgs; };
in
{
  programs.nixvim.extraPlugins = [ customPlugins.bg-nvim ];

  # bg.nvim doesn't need an explicit setup() — it activates on load and
  # transparently propagates terminal background. The original lua config
  # marked it lazy = false, which is the default for extraPlugins anyway.
}
