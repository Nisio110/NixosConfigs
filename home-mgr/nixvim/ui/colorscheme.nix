{ pkgs, ... }:

let
  customPlugins = import ../_pkgs.nix { inherit pkgs; };
in
{
  programs.nixvim = {
    extraPlugins = [ customPlugins.evergarden ];

    # Loaded early via extraConfigLuaPre so highlights are in place before
    # other plugins register their own (lualine, gitsigns, bufferline, etc).
    #
    # vim.cmd("packloadall") must run first: nixvim puts all plugins in
    # pack/*/start/ via packpath, but neovim only calls packloadall AFTER
    # init.lua finishes. Any require() in init.lua would fail without this.
    extraConfigLuaPre = ''
      vim.cmd("packloadall")
      require("evergarden").setup({
        theme = {
          variant = "fall", -- 'winter'|'fall'|'spring'|'summer'
          accent = "green",
        },
        editor = {
          transparent_background = true,
          sign = { color = "none" },
          float = {
            color = "mantle",
            solid_border = true,
          },
          completion = {
            color = "surface0",
          },
        },
      })
      vim.cmd.colorscheme("evergarden")
      {
        integrations = {
          blink_cmp = true,
          cmp = true,
          fzf_lua = true,
          gitsigns = true,
          indent_blankline = { enable = true, scope_color = 'green' },
          mini = {
            enable = true,
            animate = true,
            clue = true,
            completion = true,
            cursorword = true,
            deps = true,
            diff = true,
            files = true,
            hipatterns = true,
            icons = true,
            indentscope = true,
            jump = true,
            jump2d = true,
            map = true,
            notify = true,
            operators = true,
            pick = true,
            starters = true,
            statusline = true,
            surround = true,
            tabline = true,
            test = true,
            trailspace = true,
          },
          nvimtree = true,
          rainbow_delimiters = true,
          symbols_outline = true,
          telescope = true,
          which_key = true,
          neotree = true,
        },
}
    '';
  };
}
