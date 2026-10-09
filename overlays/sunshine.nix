{
  nixpkgs.overlays = [
    (final: prev: {
      sunshine = prev.sunshine.override {
        cudaSupport = true;
        cudaPackages = final.cudaPackages;
      };
    })
  ];
}
