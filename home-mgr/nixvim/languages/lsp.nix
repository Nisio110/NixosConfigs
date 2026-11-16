{ pkgs, ... }:

{
  programs.nixvim.plugins.lsp = {
    enable = true;

    servers = {
      # C/C++ — clangd extensions live in lang-c.nix
      clangd = {
        enable = true;
        # clangd is pulled in by nixvim, but ensuring clang-tools is on $PATH
        # gets you clang-tidy and clang-format too.
      };

      # Python — pyright covers most cases; ruff also has its own LSP if needed.
      # We do NOT enable a python formatter LSP here; conform.nvim drives ruff.
      pyright.enable = true;

      # Lua — lazydev.nvim handles workspace libs (see lang-lua.nix).
      lua_ls.enable = true;

      # Bash / shell
      bashls.enable = true;

      # Web tooling
      html.enable = true;
      cssls.enable = true;
      jsonls.enable = true;
      yamlls.enable = true;

      # Markdown
      marksman.enable = true;

      # ts_ls and rust_analyzer are intentionally NOT enabled here —
      # typescript-tools.nvim (lang-web.nix) and rustaceanvim (lang-rust.nix)
      # spawn their own server processes.
    };

    keymaps = {
      silent = true;
      lspBuf = {
        "K" = "hover";
        "gd" = "definition";
        "gr" = "references";
        "<leader>cr" = "rename";
        "<leader>ca" = "code_action";
      };
    };
  };

  # Tools that mason used to install for us, now declarative.
  home.packages = with pkgs; [
    clang-tools  # clang-format, clang-tidy, etc.
  ];
}
