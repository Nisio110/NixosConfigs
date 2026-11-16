# if nixvim is causing issues revert this file's commit
{ inputs, pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
