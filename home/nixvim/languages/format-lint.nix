{ pkgs, ... }:

{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        lua = [ "stylua" ];
        c = [ "clang-format" ];
        cpp = [ "clang-format" ];
        python = [ "ruff_format" "ruff_organize_imports" ];
        rust = [ "rustfmt" ];

        javascript = [ "prettierd" "prettier" { stop_after_first = true; } ];
        typescript = [ "prettierd" "prettier" { stop_after_first = true; } ];
        javascriptreact = [ "prettierd" "prettier" { stop_after_first = true; } ];
        typescriptreact = [ "prettierd" "prettier" { stop_after_first = true; } ];
        html = [ "prettierd" "prettier" { stop_after_first = true; } ];
        css = [ "prettierd" "prettier" { stop_after_first = true; } ];
        json = [ "prettierd" "prettier" { stop_after_first = true; } ];
        yaml = [ "prettierd" "prettier" { stop_after_first = true; } ];
        markdown = [ "prettierd" "prettier" { stop_after_first = true; } ];

        sh = [ "shfmt" ];
        bash = [ "shfmt" ];

        # Bonus: format your nix code too
        nix = [ "nixpkgs-fmt" ];
      };
    };
  };

  programs.nixvim.plugins.lint = {
    enable = true;
    lintersByFt = {
      c = [ "cppcheck" ];
      cpp = [ "cppcheck" ];
      javascript = [ "eslint_d" ];
      typescript = [ "eslint_d" ];
      javascriptreact = [ "eslint_d" ];
      typescriptreact = [ "eslint_d" ];
      python = [ "ruff" ];
      sh = [ "shellcheck" ];
      bash = [ "shellcheck" ];
      markdown = [ "markdownlint" ];
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = [ "n" "v" ];
      key = "<leader>gf";
      action.__raw = ''
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end
      '';
      options.desc = "Format buffer";
    }
    {
      mode = "n";
      key = "<leader>ul";
      action.__raw = ''function() require("lint").try_lint() end'';
      options.desc = "Run linter";
    }
  ];

  # Mason replacement: install every formatter / linter / debug binary
  # declaratively. These end up on PATH for the home-manager user.
  home.packages = with pkgs; [
    # formatters
    stylua
    # prettierd lives at the top level in nixpkgs
    prettierd
    ruff           # provides both ruff (lint) and ruff_format (via conform)
    shfmt
    rustfmt
    nixpkgs-fmt

    # linters
    cppcheck
    eslint_d
    shellcheck
    markdownlint-cli
  ];
}
