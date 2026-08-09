{
  programs.nixvim.plugins.treesitter = {
    enable = true;

    # nixvim pulls grammars from nixpkgs. `auto_install` is unused under nix —
    # parsers are built at home-manager switch time.
    grammarPackages = [ ];  # default: all grammars covered by the list below
    settings = {
      ensure_installed = [
        "lua" "vim" "vimdoc" "query"
        "c" "cpp" "rust" "python"
        "javascript" "typescript" "tsx"
        "html" "css" "json" "yaml" "toml"
        "bash" "markdown" "markdown_inline"
        "regex" "diff" "gitcommit"
        "nix"  # bonus: useful now you're editing nix daily
      ];
      auto_install = false;
      highlight.enable = true;
      indent.enable = true;
    };
  };
}
