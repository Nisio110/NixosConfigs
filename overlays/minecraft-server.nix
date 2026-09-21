{
  nixpkgs.overlays = [
    (final: prev: {
      minecraft-server = prev.minecraft-server.overrideAttrs (old: {
        src = final.fetchurl {
          url = "https://meta.fabricmc.net/v2/versions/loader/26.3/0.19.5/1.1.2/server/jar";
          sha256 = "sha256-C1atVNdiFy6Lh0jkZ/WE8HHk3t7Nk9wzbPLGiDfnkL4=";
        };
      });
    })
  ];
}
