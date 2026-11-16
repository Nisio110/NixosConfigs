{ pkgs, ... }:

let
  customPlugins = import ../_pkgs.nix { inherit pkgs; };
in
{
  programs.nixvim.plugins = {
    web-devicons.enable = true;

    bufferline = {
      enable = true;
      settings.options = {
        diagnostics = "nvim_lsp";
        always_show_bufferline = false;
        offsets = [
          { filetype = "neo-tree"; text = "Explorer"; separator = true; }
        ];
      };
    };

    notify = {
      enable = true;
      settings = {
        timeout = 3000;
        stages = "fade";
        render = "compact";
        # Query Normal bg at runtime; falls back to black when transparent.
        background_colour.__raw = ''(function()
          local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
          if hl.bg then return string.format("#%06x", hl.bg) end
          return "#000000"
        end)()'';
        # max_height / max_width are functions in the original — preserved raw.
        max_height.__raw = ''function() return math.floor(vim.o.lines * 0.75) end'';
        max_width.__raw  = ''function() return math.floor(vim.o.columns * 0.75) end'';
      };
    };

    todo-comments = {
      enable = true;
      settings = { };
    };

    render-markdown = {
      enable = true;
      settings = { };
    };

    dressing = {
      enable = true;
      settings = { };
    };

    zen-mode = {
      enable = true;
      settings = { };
    };

    trouble = {
      enable = true;
      settings = { };
    };
  };

  # extraPlugins for plugins without a first-class nixvim option.
  programs.nixvim.extraPlugins = [
    customPlugins.nvim-hlchunk
    customPlugins.nvim-foldsign
    customPlugins.smooth-resize-nvim
    customPlugins.wrapped-nvim
    customPlugins.volt  # required by wrapped-nvim
  ];

  programs.nixvim.extraConfigLua = ''
    -- nvim-foldsign needs setup(); hlchunk auto-enables; smooth-resize takes
    -- opts via setup().
    require("nvim-foldsign").setup({})
    require("smooth-resize").setup({
      disabled_fts = { "neo-tree", "yazi" },
    })

    -- nvim-notify integration: route vim.notify through it (matches the
    -- original lua/plugins/ui.lua `init` block).
    vim.notify = function(...)
      return require("notify")(...)
    end
  '';

  programs.nixvim.keymaps = [
    # bufferline
    { mode = "n"; key = "<S-h>";     action = "<cmd>BufferLineCyclePrev<cr>"; options.desc = "Prev buffer"; }
    { mode = "n"; key = "<S-l>";     action = "<cmd>BufferLineCycleNext<cr>"; options.desc = "Next buffer"; }
    { mode = "n"; key = "<leader>bp"; action = "<cmd>BufferLineTogglePin<cr>"; options.desc = "Pin buffer"; }
    { mode = "n"; key = "<leader>bd"; action = "<cmd>bdelete<cr>";             options.desc = "Delete buffer"; }

    # todo-comments
    { mode = "n"; key = "]t";          action.__raw = ''function() require("todo-comments").jump_next() end''; options.desc = "Next todo"; }
    { mode = "n"; key = "[t";          action.__raw = ''function() require("todo-comments").jump_prev() end''; options.desc = "Prev todo"; }
    { mode = "n"; key = "<leader>ft"; action = "<cmd>TodoTelescope<cr>";                                       options.desc = "Find TODOs"; }
    { mode = "n"; key = "<leader>xt"; action = "<cmd>Trouble todo toggle<cr>";                                 options.desc = "Todo list (Trouble)"; }

    # zen-mode
    { mode = "n"; key = "<leader>zz"; action = "<cmd>ZenMode<cr>"; options.desc = "Toggle Zen mode"; }

    # trouble
    { mode = "n"; key = "<leader>xx"; action = "<cmd>Trouble diagnostics toggle<cr>";                        options.desc = "Diagnostics (Trouble)"; }
    { mode = "n"; key = "<leader>xX"; action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";           options.desc = "Buffer diagnostics"; }
    { mode = "n"; key = "<leader>cs"; action = "<cmd>Trouble symbols toggle focus=false<cr>";                options.desc = "Symbols (Trouble)"; }
    { mode = "n"; key = "<leader>cl"; action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>"; options.desc = "LSP refs/defs"; }
    { mode = "n"; key = "<leader>xL"; action = "<cmd>Trouble loclist toggle<cr>";                            options.desc = "Location list"; }
    { mode = "n"; key = "<leader>xQ"; action = "<cmd>Trouble qflist toggle<cr>";                             options.desc = "Quickfix list"; }
  ];
}
