{ pkgs, ... }:

{
  programs.nixvim.plugins.typescript-tools = {
    enable = true;

    settings = {
      # capabilities are injected globally via VimEnter in completion.nix.

      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all";
          includeInlayEnumMemberValueHints = true;
          includeInlayFunctionLikeReturnTypeHints = true;
          includeInlayFunctionParameterTypeHints = true;
          includeInlayPropertyDeclarationTypeHints = true;
          includeInlayVariableTypeHints = true;
        };
      };
    };
  };

  # typescript-tools.nvim wraps tsserver, which ships with typescript itself.
  home.packages = with pkgs; [
    nodejs
    typescript
  ];
}
