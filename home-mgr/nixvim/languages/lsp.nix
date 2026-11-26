{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.lspconfig.enable = true;

    lsp = {
      servers = {
        clangd = {
          enable = true;
          package = pkgs.clang-tools;

          config.cmd = [
            "${pkgs.clang-tools}/bin/clangd"
            "--background-index"
            "--clang-tidy"
            "--completion-style=detailed"
            "--query-driver=${pkgs.gcc}/bin/*"
          ];
        };

        pyright.enable = true;
        lua_ls.enable = true;
        bashls.enable = true;

        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;
        yamlls.enable = true;

        marksman.enable = true;
      };

      keymaps = [
        { key = "K"; lspBufAction = "hover"; }
        { key = "gd"; lspBufAction = "definition"; }
        { key = "gr"; lspBufAction = "references"; }
        { key = "<leader>cr"; lspBufAction = "rename"; }
        { key = "<leader>ca"; lspBufAction = "code_action"; }
      ];
    };
  };

  home.packages = with pkgs; [
    clang-tools
    gcc
    cmake
  ];
}
