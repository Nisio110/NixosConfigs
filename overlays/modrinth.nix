{
  nixpkgs.overlays = [
    (final: prev: {
      modrinth = prev.symlinkJoin {
        name = "modrinth-app-wrapped";
        paths = [ prev.modrinth-app ];
        nativeBuildInputs = [ prev.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/ModrinthApp \
            --set GTK_MODULES "" \
            --set WEBKIT_DISABLE_COMPOSITING_MODE "1"
        '';
      };
    })
  ];
}
