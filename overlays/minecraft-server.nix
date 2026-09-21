{lib, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      minecraft-server = (prev.minecraft-server.override {
        url = "https://meta.fabricmc.net/v2/versions/loader/26.3/0.19.5/1.1.2/server/jar";
        sha1 = "";
        }).overrideAttrs (oldAttrs: {
        installPhase = ''
          runHook preInstall

          install -Dm644 $src $out/lib/minecraft/server.jar

          makeWrapper ${final.lib.getExe final.jre_headless} $out/bin/minecraft-server \
            --append-flags "-jar fabric-server-mc.26.3-loader.0.19.5-launcher.1.1.2.jar nogui" \
            ${final.lib.optionalString final.stdenv.hostPlatform.isLinux "--prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ final.udev ]}"}

          runHook postInstall
        '';
        });
    })
  ];
}
