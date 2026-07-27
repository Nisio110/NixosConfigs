{ ... }:

{
  programs.nixvim.plugins.neogit = {
    enable = true;
    settings = { };
  };

  programs.nixvim.plugins.gitsigns = {
    enable = true;

    settings = {
      signs = {
        add.text          = "│";
        change.text       = "│";
        delete.text       = "_";
        topdelete.text    = "‾";
        changedelete.text = "~";
        untracked.text    = "┆";
      };

      # on_attach has to be a function (it sets buffer-local keymaps using the
      # buffer arg). Keep it in raw lua.
      on_attach.__raw = ''
        function(buffer)
          local gs = package.loaded.gitsigns
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
          end

          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(gs.next_hunk)
            return "<Ignore>"
          end, "Next hunk")
          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(gs.prev_hunk)
            return "<Ignore>"
          end, "Previous hunk")

          map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>",  "Stage hunk")
          map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>",  "Reset hunk")
          map("n",          "<leader>ghS", gs.stage_buffer,             "Stage buffer")
          map("n",          "<leader>ghu", gs.undo_stage_hunk,          "Undo stage hunk")
          map("n",          "<leader>ghR", gs.reset_buffer,             "Reset buffer")
          map("n",          "<leader>ghp", gs.preview_hunk,             "Preview hunk")
          map("n",          "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame line")
          map("n",          "<leader>ghd", gs.diffthis,                 "Diff this")
          map({ "o", "x" }, "ih",          ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
        end
      '';
    };
  };

  programs.nixvim.keymaps = [
    { mode = "n"; key = "<leader>gg"; action = "<cmd>Neogit<cr>"; options.desc = "Neogit"; }
  ];
}
