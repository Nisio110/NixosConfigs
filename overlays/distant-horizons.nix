{ pkgs, ... }:

let
  installDir = "/var/lib/minecraft";

  distant-horizons = pkgs.stdenvNoCC.mkDerivation {
    pname = "distant-horizons";
    version = "3.3.0-26.3";

    src = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/uCdwusMi/versions/I4fvXVOw/DistantHorizons-3.3.0-26.3-fabric-neoforge.jar?mr_download_reason=standalone"; # from modrinth.com/mod/distanthorizons/version/3.3.0-26.3
      sha256 = "sha256-+lglJYfw7bJ/92Ehfj36kR+WSPk+qvazseDoYjlmN64=";
    };

    dontUnpack = true;

    installPhase = ''
      runHook preInstall
      install -Dm644 $src $out/DistantHorizons-3.3.0-26.3-fabric-neoforge.jar
      runHook postInstall
    '';
  };
in
{
  systemd.tmpfiles.rules = [
    "L+ ${installDir}/mods/DistantHorizons-3.3.0-26.3-fabric-neoforge.jar - - - - ${distant-horizons}/DistantHorizons-3.3.0-26.3-fabric-neoforge.jar"
  ];
}
