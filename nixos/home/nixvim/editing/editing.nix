{ pkgs, ... }:

let
  customPlugins = import ../_pkgs.nix { inherit pkgs; };
in
{
  programs.nixvim.plugins = {
    nvim-autopairs = {
      enable = true;
      settings = {
        check_ts = true;
        fast_wrap = { };
        # Stop autopairs from owning <CR> in insert mode so blink.cmp's confirm
        # binding fires first. The other half of the fix (calling
        # blink.cmp.on_confirm_done with autopairs.autopairs_cr()) lives in
        # completion.nix.
        map_cr = false;
      };
    };

    nvim-surround = {
      enable = true;
      settings = { };
    };

    mini = {
      enable = true;
      modules.ai = { n_lines = 500; };
    };

    comment = {
      enable = true;
      settings = { };
    };
  };

  # extraPlugins for everything without a first-class nixvim option.
  programs.nixvim.extraPlugins = [
    customPlugins.lastplace-nvim
    customPlugins.numb-nvim
    customPlugins.yankbank-nvim
    customPlugins.select-undo-nvim
    customPlugins.hypersonic-nvim
    pkgs.vimPlugins.moveline-nvim
  ];

  # Setup calls for the extraPlugins above. lastplace, numb, hypersonic each
  # need an explicit setup() call.
  programs.nixvim.extraConfigLua = ''
    require("lastplace").setup({})
    require("numb").setup({})
    require("hypersonic").setup({})
    require("yankbank").setup({})
    require("select-undo").setup({
      line_mapping    = "<leader>uS",
      partial_mapping = "<leader>us",
    })
  '';

  programs.nixvim.keymaps = [
    # yankbank
    { mode = "n"; key = "<leader>uy"; action = "<cmd>YankBank<cr>"; options.desc = "Yank history"; }

    # Hypersonic (visual selection regex explainer)
    { mode = "v"; key = "<leader>uh"; action = ":Hypersonic<cr>"; options.desc = "Explain regex (Hypersonic)"; }

    # moveline — line / block move. Requires the cargo-built shared lib (see
    # nixvim/pkgs.nix). If the build fails, drop these four bindings and the
    # moveline-nvim entry above.
    { mode = "n"; key = "<M-k>"; action.__raw = ''function() require("moveline").up() end'';          options.desc = "Move line up"; }
    { mode = "n"; key = "<M-j>"; action.__raw = ''function() require("moveline").down() end'';        options.desc = "Move line down"; }
    { mode = "v"; key = "<M-k>"; action.__raw = ''function() require("moveline").block_up() end'';    options.desc = "Move block up"; }
    { mode = "v"; key = "<M-j>"; action.__raw = ''function() require("moveline").block_down() end'';  options.desc = "Move block down"; }
  ];
}
