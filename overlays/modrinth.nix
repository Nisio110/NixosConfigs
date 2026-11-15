{
  nixpkgs.overlays = [
    (final: _: {
      modrinth = final.appimageTools.wrapType2 (finalAttrs: {
        pname = "modrinth-app";
        version = "0.21.6";

        src = final.fetchurl {
          url = "https://github.com/modrinth/code/releases/download/v${finalAttrs.version}/Modrinth.App_${finalAttrs.version}_amd64.AppImage";
          hash = "sha256-jSaNdcui+T3hXcI3OaOg6FR0a8Of7nUZ8wxU+YB7OXY=";
        };

        extraPkgs = pkgs: [ pkgs.libgpg-error ];
        profile = ''
          export GTK_MODULES=""
          export WEBKIT_DISABLE_COMPOSITING_MODE=1
        '';

        extraInstallCommands = ''

          install -m 444 -D "${finalAttrs.contents}/usr/share/applications/Modrinth App.desktop" \
            "$out/share/applications/modrinth-app.desktop"
          substituteInPlace "$out/share/applications/modrinth-app.desktop" \
            --replace-fail "Exec=ModrinthApp" "Exec=modrinth-app"
          cp -r "${finalAttrs.contents}/usr/share/icons" "$out/share"
        '';

        meta = {
          description = "Modrinth's game launcher";
          homepage = "https://modrinth.com";
          license = with final.lib.licenses; [
            gpl3Plus
            unfreeRedistributable
          ];
          mainProgram = "modrinth-app";
          platforms = [ "x86_64-linux" ];
        };
      });
    })
  ];
}
