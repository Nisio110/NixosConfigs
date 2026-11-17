{
  programs.nixvim.plugins.treesitter = {
    enable = true;

    settings = {
      ensure_installed = [
        "lua" "vim" "vimdoc" "query"
        "c" "cpp" "rust" "python"
        "javascript" "typescript" "tsx"
        "html" "css" "json" "yaml" "toml"
        "bash" "markdown" "markdown_inline"
        "regex" "diff" "gitcommit"
        "nix" 
      ];
      auto_install = true;
      highlight.enable = true;
      indent.enable = true;
    };
  };
}
