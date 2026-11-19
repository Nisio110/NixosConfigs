{pkgs, ...}: {
  # Ollama service (native CUDA support via pkgs.ollama-cuda)
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    syncModels = true;
    loadModels = [
      "qwen3.5:9b"
      "gemma4:12b"
    ];
    port = 1144;
    host = "192.168.0.19";

    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "64000";
    };
  };
}
