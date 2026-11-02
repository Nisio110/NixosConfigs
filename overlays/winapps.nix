{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: let
      system = prev.stdenv.hostPlatform.system;
      olderPkgs = import inputs.nixpkgs-freerdp {
        inherit system;
      };
    in {
      winapps = inputs.winapps.packages.${system}.winapps.override {
        freerdp = olderPkgs.freerdp;
      };
      winapps-launcher = inputs.winapps.packages.${system}.winapps-launcher.override {
        winapps = final.winapps;
      };
    })
  ];
}
