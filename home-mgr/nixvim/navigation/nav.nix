{ pkgs, ... }:

let
  customPlugins = import ../_pkgs.nix { inherit pkgs; };
in
{
  programs.nixvim.plugins = {
    flash = {
      enable = true;
      settings = { };
    };

    harpoon = {
      enable = true;
      # nixvim's harpoon module is Harpoon2-compatible. The original lua
      # config doesn't use harpoon's telescope picker — keymaps go through
      # harpoon's own UI — so no extension is wired here.
    };

    aerial = {
      enable = true;
      settings = {
        attach_mode = "global";
        backends = [ "lsp" "treesitter" "markdown" "man" ];
        layout.default_direction = "prefer_right";
      };
    };

    toggleterm = {
      enable = true;
      settings = {
        # "<C-\>" in Neovim key notation. open_mapping is emitted as raw Lua
        # by nixvim (unquoted), so __raw is needed to supply the Lua string literal.
        open_mapping.__raw = ''"<c-\\>"'';
        shade_terminals = true;
        direction = "float";
        float_opts.border = "curved";
        # `size` was a function in the original; preserved as raw lua.
        size.__raw = ''
          function(term)
            if term.direction == "horizontal" then
              return 15
            elseif term.direction == "vertical" then
              return math.floor(vim.o.columns * 0.4)
            end
          end
        '';
      };
    };

    persistence = {
      enable = true;
      settings = { };
    };
  };

  # tabman.nvim has no nixvim option — extraPlugin.
  programs.nixvim.extraPlugins = [ customPlugins.tabman-nvim ];

  programs.nixvim.keymaps = [
    # flash
    { mode = [ "n" "x" "o" ]; key = "s"; action.__raw = ''function() require("flash").jump() end''; options.desc = "Flash"; }
    { mode = [ "n" "x" "o" ]; key = "S"; action.__raw = ''function() require("flash").treesitter() end''; options.desc = "Flash treesitter"; }
    { mode = "o";              key = "r"; action.__raw = ''function() require("flash").remote() end''; options.desc = "Remote flash"; }
    { mode = [ "o" "x" ];      key = "R"; action.__raw = ''function() require("flash").treesitter_search() end''; options.desc = "Treesitter search"; }
    { mode = "c";              key = "<c-s>"; action.__raw = ''function() require("flash").toggle() end''; options.desc = "Toggle Flash search"; }

    # harpoon
    { mode = "n"; key = "<leader>ha"; action.__raw = ''function() require("harpoon"):list():add() end''; options.desc = "Harpoon add file"; }
    { mode = "n"; key = "<leader>hh"; action.__raw = ''function() local h = require("harpoon"); h.ui:toggle_quick_menu(h:list()) end''; options.desc = "Harpoon menu"; }
    { mode = "n"; key = "<leader>1";  action.__raw = ''function() require("harpoon"):list():select(1) end''; options.desc = "Harpoon 1"; }
    { mode = "n"; key = "<leader>2";  action.__raw = ''function() require("harpoon"):list():select(2) end''; options.desc = "Harpoon 2"; }
    { mode = "n"; key = "<leader>3";  action.__raw = ''function() require("harpoon"):list():select(3) end''; options.desc = "Harpoon 3"; }
    { mode = "n"; key = "<leader>4";  action.__raw = ''function() require("harpoon"):list():select(4) end''; options.desc = "Harpoon 4"; }

    # aerial
    { mode = "n"; key = "<leader>cO"; action = "<cmd>AerialToggle!<cr>"; options.desc = "Symbol outline (Aerial)"; }

    # toggleterm — same 4-backslash rule as open_mapping above
    { mode = [ "n" "t" ]; key = "<C-\\\\>";      action = "<cmd>ToggleTerm<cr>";                      options.desc = "Toggle terminal"; }
    { mode = "n";          key = "<leader>tf"; action = "<cmd>ToggleTerm direction=float<cr>";      options.desc = "Floating terminal"; }
    { mode = "n";          key = "<leader>th"; action = "<cmd>ToggleTerm direction=horizontal<cr>"; options.desc = "Horizontal terminal"; }
    { mode = "n";          key = "<leader>tv"; action = "<cmd>ToggleTerm direction=vertical<cr>";   options.desc = "Vertical terminal"; }

    # persistence
    { mode = "n"; key = "<leader>qs"; action.__raw = ''function() require("persistence").load() end''; options.desc = "Restore session"; }
    { mode = "n"; key = "<leader>ql"; action.__raw = ''function() require("persistence").load({ last = true }) end''; options.desc = "Restore last session"; }
    { mode = "n"; key = "<leader>qd"; action.__raw = ''function() require("persistence").stop() end''; options.desc = "Stop persisting session"; }

    # tabman
    { mode = "n"; key = "<leader>wt"; action = "<cmd>Tabman<cr>"; options.desc = "Tab manager"; }
  ];
}
