{ pkgs, ... }:
{
  environment = {
    pathsToLink = [ "/home/oisin/Scripts" ];

    localBinInPath = true;
    shells = [pkgs.zsh pkgs.bash];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      LIBVIRT_DEFAULT_URI = "qemu:///system";
    };

    extraInit = ''
      alias xdg-open open
      export PATH="$HOME/.bun/bin:$PATH"
    '';
  };
}
