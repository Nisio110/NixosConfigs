{
  nixpkgs.overlays = [
    (final: prev: {
      minecraft-server = (prev.minecraft-server.override {
        url = "https://meta.fabricmc.net/v2/versions/loader/26.3/0.19.5/1.1.2/server/jar";
      });
    })
  ];
}
