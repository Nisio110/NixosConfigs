{
  nixpkgs.overlays = [
    (final: prev: {
      sunshine = (prev.sunshine.override {
        cudaSupport = true;
        cudaPackages = final.cudaPackages;
      }).overrideAttrs (finalAttrs: oldAttrs: {
        version = "2026.914.233613";
        src = prev.fetchFromGitHub {
          owner = "LizardByte";
          repo = "Sunshine";
          tag = "v${finalAttrs.version}";
          hash = "sha256-HqbswLvX/UiY3nOwxSesBMqnFAF0zKP1ueE6PwDtTNs=";
          fetchSubmodules = true;
        };
         buildInputs = oldAttrs.buildInputs ++ [
          prev.libsForQt5.qtbase
          prev.libsForQt5.qtsvg
          prev.libsForQt5.wrapQtAppsHook
        ];

        ui = prev.buildNpmPackage rec {
         inherit (finalAttrs) src version;
         pname = oldAttrs.ui.pname;
         npmDepsHash = "sha256-/uY+zvYxQG0Yb8kygwF48YfS+Km0bcQBW4poaqkeJXs=";
         installPhase = oldAttrs.ui.installPhase;
        };
      });
    })
  ];
}
