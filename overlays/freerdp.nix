{ inputs, ... }:
{
  nixpkgs.overlays = [ 
    (final: prev: {
      freerdp = prev.freerdp.overrideAttrs (finalAttrs: oldAttrs: {
        version = "3.33.0";
        src = oldAttrs.src.override {
          hash = "sha256-jp4Q4M4rtHp/3ISMx8jAMxB35Dsp2wxTHRcyPu8JnSU=";
        };
      });
      winapps = inputs.winapps.packages.${prev.stdenv.hostPlatform.system}.winapps.override {
        freerdp = final.freerdp;
      };
      winapps-launcher = inputs.winapps.packages.${prev.stdenv.hostPlatform.system}.winapps-launcher.override {
        winapps = final.winapps;
      };
    })
  ];
}
