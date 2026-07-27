{ ... }:

{
  programs.nixvim.plugins.telescope = {
    enable = true;

    extensions.ui-select = {
      enable = true;
      settings = {
        # Original used get_dropdown {} with no overrides; equivalent here.
        # nixvim wires the load_extension call for us when extensions.* is set.
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<C-p>";
      action.__raw = ''require("telescope.builtin").find_files'';
    }
    {
      mode = "n";
      key = "<leader>fg";
      action.__raw = ''require("telescope.builtin").live_grep'';
    }
  ];
}
