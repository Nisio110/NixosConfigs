{
  programs.nixvim.plugins.clangd-extensions = {
    enable = true;

    settings = {
      inlay_hints = {
        # vim.fn.has("nvim-0.10") == 1 — we're on a modern nvim from nixpkgs,
        # so just hard-code true here.
        inline = true;
      };

      ast = {
        role_icons = {
          type = "";
          declaration = "";
          expression = "";
          specifier = "";
          statement = "";
          "template argument" = "";
        };
      };
    };
  };
}
