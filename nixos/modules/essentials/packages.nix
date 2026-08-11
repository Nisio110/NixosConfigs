{ pkgs, inputs, ... }:
let 
packages = nix ++ tools ++ libraries ++ misc;

nix = with pkgs; [
  alejandra # Formatter needed by noboilerplate rebuild script
  manix man-pages man-pages-posix # documentation
  nixos-option
  nix-search-cli
  nix-output-monitor
  sops
];

tools = with pkgs; [
  neovim
  wget curl 
  whois dig nmap traceroute tcpdump
  ntfs3g parted
  pulseaudio
  zip unzip
  btop
  mangohud
  steamcmd
  dua # disk usage analyzer
  sshfs
  cmake
  docker
  docker-compose
  localsend
  inputs.compose2nix.packages.x86_64-linux.default
];

libraries = with pkgs; [
  linuxPackages.nvidia_x11
  vkd3d-proton vkd3d
];

misc = with pkgs; [
  cmatrix
  mpv
];


services = {
  qbittorrent.enable = true;
  input-remapper.enable = true;
};

programs = {
  zsh.enable = true;
  # if traceroute & ping had a baby
  mtr.enable = true;
  chromium.enable = true;
  steam.enable = true;
  # nix unified cli tool
  nh.enable = true;
  thunar.enable = true;
  # gpg encryption agent, can be used instead of ssh-agent
  gnupg.agent.enable = true;
};

services = {
  input-remapper.enableUdevRules = false;
};

programs = {
  thunar.plugins = with pkgs; [thunar-archive-plugin thunar-volman];
  gnupg.agent.enableSSHSupport = true; 

  steam = {
    extraCompatPackages = with pkgs; [proton-ge-bin];
    protontricks.enable = true;
    extest.enable = true;
  };

  nh = {
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/oisin/Nixos";
  };

};

in {
  environment.systemPackages = packages;
  inherit services programs;

  documentation.dev.enable = true;
}
