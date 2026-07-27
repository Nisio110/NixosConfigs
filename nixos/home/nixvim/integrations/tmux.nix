{ pkgs, ... }:

let
  customPlugins = import ../_pkgs.nix { inherit pkgs; };
in
{
  # tmux.nvim itself is in nixpkgs.vimPlugins. We use extraPlugins because we
  # want a conditional setup() guard ($TMUX must be set), and the cleanest way
  # to express that conditional is a small lua block — easier than fighting
  # nixvim's option API.
  programs.nixvim.extraPlugins = [
    pkgs.vimPlugins.tmux-nvim
    customPlugins.switchboard-nvim
  ];

  programs.nixvim.extraConfigLua = ''
    -- tmux.nvim: only initialise when nvim is running inside a tmux session.
    if vim.env.TMUX ~= nil then
      require("tmux").setup({
        copy_sync = { enable = true },
        navigation = {
          cycle_navigation = true,
          enable_default_keybindings = true,
        },
        -- resize defaults (<A-h/j/k/l>) clash with moveline.nvim's <A-j>/<A-k>
        resize = { enable_default_keybindings = false },
      })
    end

    -- switchboard.nvim: build/run task helper, used by <leader>rb / <leader>rr.
    require("switchboard").setup({
      build_run_config = {
        { extension = { "c", "cpp", "h", "hpp" }, commands = { build = "make",        run = "make run" } },
        { extension = { "rs" },                   commands = { build = "cargo build", run = "cargo run" } },
      },
    })
  '';

  programs.nixvim.keymaps = [
    { mode = "n"; key = "<leader>rb"; action = "<cmd>Switchboard split build<cr>"; options.desc = "Build (switchboard)"; }
    { mode = "n"; key = "<leader>rr"; action = "<cmd>Switchboard split run<cr>";   options.desc = "Run (switchboard)"; }
  ];
}
