{pkgs,...}: {

  services.ollama = {
    enable = false;
    package = pkgs.ollama-cuda;
    loadModels = [
      "qwen3.5:9b"
    ];
  };

  # because i am not waiting to compile cuda from source
   nix.settings = {
    substituters = [ "https://cache.nixos-cuda.org" ];
    trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
  };
}
