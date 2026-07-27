{ ... }:

{
  programs.nixvim.plugins.blink-cmp = {
    enable = true;

    settings = {
      keymap.preset = "default";
      appearance.nerd_font_variant = "mono";

      completion = {
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 200;
        };
        ghost_text.enabled = true;
      };

      sources = {
        # The lua config used lazy.nvim's `opts_extend = { "sources.default" }`
        # in blink-cmp.lua so language-specific specs (like lang-lua.lua) could
        # APPEND to this list. nixvim has no equivalent additive list merge for
        # nested plugin settings, so we declare the full list here once.
        default = [ "lsp" "path" "snippets" "buffer" "lazydev" ];

        # lazydev source registration (was lang-lua.lua → blink.cmp.providers).
        providers.lazydev = {
          name = "LazyDev";
          module = "lazydev.integrations.blink";
          score_offset = 100;
        };
      };

      snippets.preset = "default";
      signature.enabled = true;
      fuzzy.implementation = "rust";
    };
  };

  # nvim-autopairs maps <CR> in insert mode by default, which intercepts
  # blink.cmp's confirm binding before it fires. The fix is two-part:
  #   1. autopairs opts.map_cr = false (done in editing.nix)
  #   2. blink.cmp.on_confirm_done(autopairs.autopairs_cr()) (done here)
  #
  # Also: inject blink.cmp capabilities globally for ALL LSP servers here
  # (including rustaceanvim and typescript-tools which set their config tables
  # at init.lua top-level, too early for a direct require("blink.cmp") call).
  # VimEnter fires before any FileType/LspAttach, so capabilities land before
  # the first server starts. vim.lsp.config("*", ...) requires neovim >= 0.11.
  programs.nixvim.extraConfigLua = ''
    do
      local ok_blink, blink = pcall(require, "blink.cmp")
      local ok_autopairs, autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if ok_blink and ok_autopairs and blink.on_confirm_done ~= nil then
        blink.on_confirm_done(autopairs.autopairs_cr())
      end
    end

    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        local ok, blink = pcall(require, "blink.cmp")
        if ok and vim.lsp.config then
          vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities() })
        end
      end,
    })
  '';
}
