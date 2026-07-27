{ pkgs, ... }:

let
  # codelldb ships inside the vscode-lldb extension; the binary we want is the
  # adapter inside its share directory.
  codelldb = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
in
{
  programs.nixvim.plugins.dap.enable = true;
  programs.nixvim.plugins.dap-ui.enable = true;

  # The original lua config did a few things:
  #   - registered the codelldb adapter (path used to come from mason)
  #   - registered the lldb adapter conditionally on lldb-dap being on PATH
  #   - set c / cpp / rust configurations
  #   - opened/closed dap-ui on session events
  #   - set keymaps under <leader>d*
  #
  # We do all of that in extraConfigLua so the function refs / closures stay
  # legible and don't need to be encoded in __raw blocks scattered through nix.
  programs.nixvim.extraConfigLua = ''
    do
      local dap = require("dap")
      local dapui = require("dapui")

      dap.adapters.codelldb = {
        type = "server",
        port = "''${port}",
        executable = {
          command = "${codelldb}",
          args = { "--port", "''${port}" },
        },
      }

      local lldb_dap = vim.fn.exepath("lldb-dap")
      if lldb_dap ~= "" then
        dap.adapters.lldb = {
          type = "executable",
          command = lldb_dap,
          name = "lldb",
        }
      end

      dap.configurations.c = {
        {
          name = "Launch (codelldb)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input(vim.fn.getcwd() .. "/build/")
          end,
          cwd = "''${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.c

      dap.listeners.before.attach.dapui_config           = function() dapui.open() end
      dap.listeners.before.launch.dapui_config           = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config     = function() dapui.close() end

      vim.keymap.set("n", "<Leader>dt",  dap.toggle_breakpoint, {})
      vim.keymap.set("n", "<Leader>dc",  dap.continue,          {})
      vim.keymap.set("n", "<Leader>dso", dap.step_over,         {})
      vim.keymap.set("n", "<Leader>dsi", dap.step_into,         {})
      vim.keymap.set("n", "<Leader>dsu", dap.step_out,          {})
      vim.keymap.set("n", "<Leader>dr",  dap.repl.open,         {})
      vim.keymap.set("n", "<Leader>dui", dapui.toggle,          {})
    end
  '';

  # lldb-dap (for the conditional adapter above). If you don't want lldb on
  # your system, remove this and the lldb adapter block will be skipped.
  home.packages = [ pkgs.lldb ];
}
