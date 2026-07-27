{ pkgs, secretsDir, ... }:
{
  imports = [ ./starship.nix ];

  home.shellAliases = {
    vim        = "nvim";
    reload     = "source ~/.zshrc";
    freload    = "clear; source ~/.zshrc";
    sreload    = "NO_FASTFETCH=1; source ~/.zshrc";
  };


  programs.zsh = {
    enable = true;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = false;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "colored-man-pages"
        "tmux"
      ];
    };
    history = {
      size       = 50000;
      save       = 50000;
      extended   = true;
      ignoreDups = true;
      share      = true;
    };


    initContent = ''
      GITHUB_TOKEN="$(cat ${secretsDir}/github_token)"

      # Auto-start a named tmux session for each new interactive non-tmux shell.
      if command -v tmux &>/dev/null && [[ -z $TMUX ]] && [[ $- == *i* ]]; then
        _n=0
        while tmux has-session -t "term$_n" 2>/dev/null; do
          (( _n++ ))
        done
        exec tmux new-session -s "term$_n"
      fi

      [[ ''${NO_FASTFETCH:-0} -eq 0 ]] && fastfetch
    '';
  };

  programs.bash.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };
}
