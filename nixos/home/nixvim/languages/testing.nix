{
  programs.nixvim.plugins.neotest = {
    enable = true;
    adapters = {
      python = {
        enable = true;
        settings.dap.justMyCode = false;
      };
      rust.enable = true;
      vitest.enable = true;
    };
  };

  programs.nixvim.plugins.overseer = {
    enable = true;
    settings = { };
  };

  programs.nixvim.keymaps = [
    { mode = "n"; key = "<leader>rn"; action.__raw = ''function() require("neotest").run.run() end''; options.desc = "Run nearest test"; }
    { mode = "n"; key = "<leader>rf"; action.__raw = ''function() require("neotest").run.run(vim.fn.expand("%")) end''; options.desc = "Run file tests"; }
    { mode = "n"; key = "<leader>rl"; action.__raw = ''function() require("neotest").run.run_last() end''; options.desc = "Run last test"; }
    { mode = "n"; key = "<leader>rs"; action.__raw = ''function() require("neotest").summary.toggle() end''; options.desc = "Toggle summary"; }
    { mode = "n"; key = "<leader>ro"; action.__raw = ''function() require("neotest").output.open({ enter = true }) end''; options.desc = "Test output"; }
    { mode = "n"; key = "<leader>rp"; action.__raw = ''function() require("neotest").output_panel.toggle() end''; options.desc = "Output panel"; }
    { mode = "n"; key = "<leader>rd"; action.__raw = ''function() require("neotest").run.run({ strategy = "dap" }) end''; options.desc = "Debug nearest test"; }
    { mode = "n"; key = "<leader>rx"; action.__raw = ''function() require("neotest").run.stop() end''; options.desc = "Stop test"; }

    { mode = "n"; key = "<leader>ot"; action = "<cmd>OverseerToggle<cr>";      options.desc = "Toggle task list"; }
    { mode = "n"; key = "<leader>or"; action = "<cmd>OverseerRun<cr>";         options.desc = "Run task"; }
    { mode = "n"; key = "<leader>oc"; action = "<cmd>OverseerRunCmd<cr>";      options.desc = "Run command"; }
    { mode = "n"; key = "<leader>oa"; action = "<cmd>OverseerQuickAction<cr>"; options.desc = "Task quick action"; }
    { mode = "n"; key = "<leader>oi"; action = "<cmd>OverseerInfo<cr>";        options.desc = "Task info"; }
  ];
}
