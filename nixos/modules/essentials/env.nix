{ pkgs, secretsDir, ... }:
{
  environment = {
    pathsToLink = [ "/home/oisin/Scripts" ];

    localBinInPath = true;
    shells = [pkgs.zsh pkgs.bash];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      LIBVIRT_DEFAULT_URI = "qemu:///system";
      SOPS_AGE_KEY_FILE="${secretsDir}/sops/age/keys.txt";
    };

    extraInit = ''
      alias xdg-open open
      export PATH="$HOME/.bun/bin:$PATH"
    '';
  };
}
