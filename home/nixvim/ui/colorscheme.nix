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
    '';
  };
}
