{ pkgs, ... }:

let
  customPlugins = import ../_pkgs.nix { inherit pkgs; };
in
{
  programs.nixvim.extraPlugins = [
    customPlugins.remote-ssh-nvim
    customPlugins.telescope-remote-buffer
  ];

  programs.nixvim.extraConfigLua = ''
    require("remote-ssh").setup({})
  '';

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>uR";
      action = "<cmd>RemoteOpen<cr>";
      options.desc = "Remote open (SSH)";
    }
  ];
}
