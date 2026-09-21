{ pkgs, ... }:

let
  installDir = "/var/lib/minecraft";

  distant-horizons = pkgs.stdenvNoCC.mkDerivation {
    pname = "distant-horizons";
    version = "3.3.0-26.2";

    src = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/uCdwusMi/versions/3CtFgbnO/DistantHorizons-3.3.0-26.2-fabric-neoforge.jar?mr_download_reason=standalone";
      sha256 = "sha256-jNbFkmdmliz4F2CbkeAaYWzltjnvlcxYVsHfy92fP50=";
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
