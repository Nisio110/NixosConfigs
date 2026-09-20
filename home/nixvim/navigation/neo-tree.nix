{
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    settings = {
      window.width = 30;

      default_component_configs = {
        git_status.symbols = {
          added     = "";
          modified  = "";
          deleted   = "";
          renamed   = "";
          untracked = "";
          ignored   = "◌";
          unstaged  = "";
          staged    = "";
          conflict  = "";
        };
      };

      filesystem.filtered_items = {
        visible = true;
        hide_dotfiles = false;
        hide_gitignored = false;
      };
    };
  };

  # The original config relinks a few highlight groups so dotfiles/ignored
  # files don't render dimmed when filtered_items.visible = true. Done via
  # autoCmd because it has to re-run on every :colorscheme change.
  programs.nixvim.extraConfigLua = ''
    do
      local function relink()
        vim.api.nvim_set_hl(0, "NeoTreeGitIgnored",   { link = "NeoTreeFileName" })
        vim.api.nvim_set_hl(0, "NeoTreeDotfile",      { link = "NeoTreeFileName" })
        vim.api.nvim_set_hl(0, "NeoTreeHiddenByName", { link = "NeoTreeFileName" })
      end
      relink()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = relink })
    end
  '';

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<C-n>";
      action = ":Neotree filesystem toggle reveal left<CR>";
    }
  ];
}
