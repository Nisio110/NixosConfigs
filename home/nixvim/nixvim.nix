{ inputs, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    # Give nixvim its own nixpkgs (pinned by nixvim's flake input), but hand it
    # an already-instantiated package set instead of a `source` path. Using
    # `nixpkgs.source` makes nixvim build the set lazily from its own config,
    # which the new lsp.servers package eval turns into infinite recursion.
    nixpkgs.pkgs = import inputs.nixvim.inputs.nixpkgs {
      inherit (pkgs.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
    viAlias = true;
    vimAlias = true;
  };
}
