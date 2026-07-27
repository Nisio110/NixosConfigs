{ ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = ''
        [┌──](bold purple)$username$hostname$directory$git_branch
        [└> ](bold purple)
      '';
      username = {
        show_always = true;
        format      = "[$user]($style) [@](bold purple) ";
        style_user  = "purple";
        style_root  = "bold yellow";
      };
      hostname = {
        ssh_only = false;
        style    = "purple";
        format   = "[$hostname]($style) [in](bold purple) ";
      };
      directory = {
        style           = "purple";
        format          = "[$read_only]($read_only_style)[$path]($style) ";
        read_only       = "(ℝ)";
        read_only_style = "purple";
      };
      git_branch = {
        style  = "purple";
        format = ''[\($branch(:$remote_branch)\)]($style) '';
      };
    };
  };
}
