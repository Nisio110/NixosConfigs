{
  nixpkgs.overlays = [
    (final: prev: {
      minecraft-server = prev.minecraft-server.overrideAttrs (old: {
        version = "26.2";
        src = final.fetchurl {
          url = "https://meta.fabricmc.net/v2/versions/loader/26.2/0.19.5/1.1.2/server/jar";
          sha256 = "sha256-8dK6/Qs7l2MLDN2OiQzRAts9vmCHejilyBOqkp5pESc=";
        };
      });
    })
  ];
}
