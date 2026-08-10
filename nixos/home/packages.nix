{ pkgs, inputs, ... }:
let
 
  bun = pkgs.bun.overrideAttrs (prev: {
    version = "latest";
    # The input is the raw .zip (type = "file"); rename it to a *.zip store path
    # so bun's generic unpackPhase recognises and unzips it.
    src = pkgs.runCommandLocal 
      "bun-linux-x64.zip" 
      { } 
      "cp ${inputs.bun-bin} $out";
  });

  oh-my-pi = pkgs.writeShellApplication {
    name = "omp";
    runtimeInputs = [ bun ];
    text = ''
      bun_bin="$(bun pm bin -g)"
      omp_bin="$bun_bin/omp"
      if [ ! -x "$omp_bin" ]; then
        bun install -g @oh-my-pi/pi-coding-agent
      fi
      exec "$omp_bin" "$@"
    '';
  };
  apps = with pkgs; [
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
    slack
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
    libnotify
    oh-my-pi
    netbird
    claude-code
    kitty-img
    qbittorrent
    weathr
    qbittorrent-cli
    joplin-cli
  ];

  # Spawned by the niri session — see niri/niri.nix.
  # waybar, mako and fuzzel come from their home-manager modules.
  niri = with pkgs; [
    swaybg
    xwayland-satellite
  ];

  homePkgs = dev ++ apps ++ misc ++ niri;

in {home.packages = homePkgs;}
