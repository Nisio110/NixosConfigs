{ pkgs, ... }:

{
  programs.nixvim.plugins.rustaceanvim = {
    enable = true;

    settings = {
      server = {
        # capabilities are injected globally via VimEnter in completion.nix —
        # require("blink.cmp") at init.lua top-level fails before blink's lua
        # dir is in the runtimepath (vim.g.rustaceanvim is set at init time).

        default_settings = {
          "rust-analyzer" = {
            cargo = { allFeatures = true; };
            checkOnSave = { command = "clippy"; };
            inlayHints = {
              chainingHints.enable = true;
              closingBraceHints = { enable = true; minLines = 25; };
              parameterHints.enable = true;
              typeHints.enable = true;
              renderColons = true;
            };
          };
        };
      };
    };
  };

  # rust-analyzer is provided by the rust toolchain. If you already manage rust
  # via rustup or a project-local toolchain file (rust-toolchain.toml), drop
  # this — rustaceanvim will find rust-analyzer on PATH either way.
  home.packages = with pkgs; [
    rust-analyzer
    cargo
    rustc
  ];
}
