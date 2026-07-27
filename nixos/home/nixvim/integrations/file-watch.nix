{ pkgs, ... }:

let
  customPlugins = import ../_pkgs.nix { inherit pkgs; };
in
{
  programs.nixvim.extraPlugins = [ customPlugins.nvim-file-watch ];

  programs.nixvim.extraConfigLua = ''
    require("file-watch").setup({ notify = false })
  '';

  # The plugin registers user commands :FileWatchEnable / :FileWatchDisable /
  # :FileWatchToggle / :FileWatchStatus on its own.
}
