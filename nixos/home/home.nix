{ pkgs, inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.beta
    inputs.nixvim.homeModules.nixvim
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };
  
  home.stateVersion = "25.11";
}
