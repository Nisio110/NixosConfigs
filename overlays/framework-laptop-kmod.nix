{
  nixpkgs.overlays = [
    (final: prev: {
      linuxPackages_7_3 = prev.linuxPackages_7_3.extend (kernelFinal: kernelPrev: {
        framework-laptop-kmod = kernelPrev.framework-laptop-kmod.overrideAttrs (old: {
          # Use Kbuild installation so NixOS's signing rule emits the .ko.cer.
          makeFlags = (old.makeFlags or []) ++ [
            "INSTALL_MOD_PATH=${builtins.placeholder "out"}"
            "DEPMOD=true"
          ];
          installPhase = null;
          installTargets = [ "modules_install" ];
        });
      });
    })
  ];
}
