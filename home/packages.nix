{ pkgs, inputs, ... }:
let
 
  # NOTE
  # might be better to structure these as one list and
  # categorise with comments instead
  apps = with pkgs; [
    prismlauncher
    modrinth
    kando
    libreoffice
    vesktop
    zapzap
    kdePackages.filelight
    jellyfin-desktop
    ente-auth
    spotify
    obsidian
    avrdudess
    joplin-desktop
    kicad
    freecad
    orca-slicer
    moonlight-qt
    krita
    ltspice
    virtualbox
    cisco-packet-tracer_9
  ];

  dev = with pkgs; [
    gcc
    rustc
    cargo
    python3
    codex
    python314Packages.pip
    bun
    gh
    avrdude
    forgejo-cli
    nodejs
  ];

  misc = with pkgs; [
    omp
    libnotify
    netbird
    claude-code
    kitty-img
    qbittorrent
    weathr
    qbittorrent-cli
    joplin-cli
    bottles
    ethtool
    tree
  ];

  # Spawned by the niri session — see niri/niri.nix.
  # waybar, mako and fuzzel come from their home-manager modules.
  niri = with pkgs; [
    swaybg
    xwayland-satellite
  ];

  homePkgs = dev ++ apps ++ misc ++ niri;

in {home.packages = homePkgs;}
