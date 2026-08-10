# FlashForge WebUI — web dashboard for the FlashForge printer at 192.168.0.20.
# Upstream ships a dynamically-linked Node binary; it runs inside a nixos/nix
# container whose entrypoint realises the loader + C++ runtime with nix on
# first boot (cached in the flashforge-webui-nix named volume thereafter).
# Reachable via nginx at print.tetocorp.ie (default password: changeme).
{ pkgs, ... }:
let
  version = "1.1.0";

  webuiBin = pkgs.fetchurl {
    url = "https://github.com/Parallel-7/FlashForgeWebUI/releases/download/v${version}/flashforge-webui-linux-x64.bin";
    sha256 = "18ibpzvpjkixigmv6wblqsakfj1ragaa4qbc12gc768ml5jisryy";
    executable = true;
  };

  entrypoint = pkgs.writeScript "flashforge-webui-entrypoint" ''
    #!/bin/sh
    set -eu

    # The binary expects an FHS loader at /lib64 and libstdc++ on the library
    # path; provide both from the container's bundled nixpkgs channel.
    glibc=$(nix-build --no-out-link '<nixpkgs>' -A glibc)
    gcclib=$(nix-build --no-out-link '<nixpkgs>' -A gcc.cc.lib)

    mkdir -p /lib64
    ln -sf "$glibc/lib/ld-linux-x86-64.so.2" /lib64/ld-linux-x86-64.so.2
    export LD_LIBRARY_PATH="$gcclib/lib:$glibc/lib"

    exec /flashforge-webui --printers="192.168.0.20:new:24d58190"
  '';
in
{
  virtualisation.docker.enable = true;

  virtualisation.oci-containers = {
    backend = "docker";
    containers.flashforge-webui = {
      image = "nixos/nix:2.35.1";
      autoStart = true;
      entrypoint = "/entrypoint";

      # Localhost only — external access goes through nginx.
      ports = [ "127.0.0.1:3000:3000/tcp" ];

      volumes = [
        "${entrypoint}:/entrypoint:ro"
        "${webuiBin}:/flashforge-webui:ro"
        "/var/lib/flashforge-webui:/data"
        "flashforge-webui-nix:/nix" # persists realised deps across restarts
      ];

      environment = {
        DATA_DIR = "/data";
        TZ = "Europe/London";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/flashforge-webui 0755 root root -"
  ];
}
