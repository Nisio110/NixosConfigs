{
  nixpkgs.overlays = [ 
    (final: prev: {
      freerdp = prev.freerdp.overrideAttrs (finalAttrs: oldAttrs: {
        version = "3.33.0";
        # Keep src as a fetcher derivation; replace this placeholder after fetching.
        src = oldAttrs.src.override {
          tag = finalAttrs.version;
          hash = "sha256-jp4Q4M4rtHp/3ISMx8jAMxB35Dsp2wxTHRcyPu8JnSU=";
        };
      });
    })
  ];
}
