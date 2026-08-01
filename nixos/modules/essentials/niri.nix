{inputs, ...}:
{
  imports = [ inputs.niri-config.nixosModules.niri ];

  programs.niri.enable = true;
}
