{
  nixpkgs.overlays = [
    (final: prev: {
      linuxPackages_7_3 = prev.linuxPackages_7_3.extend (kernelFinal: kernelPrev: {
        virtualbox = kernelPrev.virtualbox.overrideAttrs (old: {
          # Upstream disables Kbuild signing unless explicitly allowed. Use the
          # NixOS signing rule so modules_install also emits each module's .cer.
          makeFlags = (old.makeFlags or []) ++ kernelFinal.kernelModuleMakeFlags ++ [
            "VBOX_ALLOW_MODULE_SIGNING=1"
            "DEPMOD=true"
          ];
        });
      });
    })
  ];
}
