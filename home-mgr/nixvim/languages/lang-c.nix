{
  programs.nixvim.plugins.clangd-extensions = {
    enable = true;

    settings = {
      inlay_hints = {
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
