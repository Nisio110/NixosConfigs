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
}

# Default preset keymap
# "<C-space>" = [
#        "show"
#        "show_documentation"
#        "hide_documentation"
#      ];
#      "<C-e>" = [ "hide" ];
#      "<C-y>" = [ "select_and_accept" ];
#
#      "<Up>" = [
#        "select_prev"
#        "fallback"
#      ];
#      "<Down>" = [
#        "select_next"
#        "fallback"
#      ];
#      "<C-p>" = [
#        "select_prev"
#        "fallback"
#      ];
#      "<C-n>" = [
#        "select_next"
#        "fallback"
#      ];
#
#      "<C-b>" = [
#        "scroll_documentation_up"
#        "fallback"
#      ];
#      "<C-f>" = [
#        "scroll_documentation_down"
#        "fallback"
#      ];
#
#      "<Tab>" = [
#        "snippet_forward"
#        "fallback"
#      ];
#      "<S-Tab>" = [
#        "snippet_backward"
#        "fallback"
##      ];
