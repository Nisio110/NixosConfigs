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
  
  programs.git = {
      enable = true;
      settings.user = {
        name = "Nisio110";
        email = "laneoisin64@gmail.com";
      };
  };
  home.stateVersion = "25.11";
}
