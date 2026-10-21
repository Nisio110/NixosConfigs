# framework kernel wouldnt build 7.2.11 (20/10/2026)
# chatgpt claimed it was a kernel module signing issue
{
  nixpkgs.overlays = [
    (final: prev: {
      linuxPackages_latest = prev.linuxPackages_latest.extend (kernelFinal: kernelPrev: {
        framework-laptop-kmod = kernelPrev.framework-laptop-kmod.overrideAttrs (old: {
          # The module aggregator requires a certificate for each external module.
          # Sign after stripping so the signature covers the final module contents.
          postFixup = (old.postFixup or "") + ''
            ${final.kmodigest}/bin/kmodigest \
              $out/lib/modules/${kernelFinal.kernel.modDirVersion}/extra/framework_laptop.ko
          '';
        });
      });
    })
  ];
}
