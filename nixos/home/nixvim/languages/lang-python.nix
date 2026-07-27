{ pkgs, ... }:

let
  # Python interpreter with debugpy available. dap-python wants the python
  # executable that has the debugpy module importable.
  debugpyPython = pkgs.python3.withPackages (ps: [ ps.debugpy ]);
in
{
  programs.nixvim.plugins.dap-python = {
    enable = true;
    # Replaces:  vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
    adapterPythonPath = "${debugpyPython}/bin/python";
  };

  programs.nixvim.plugins.venv-selector = {
    enable = true;
    settings = { };  # original config used empty opts; keep parity
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>cv";
      action = "<cmd>VenvSelect<cr>";
      options.desc = "Select venv";
    }
  ];
}
