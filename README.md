# My big boy NixOS config

hiiiii :3

- [ ] Should move as much of my config to hm as possible

## Kernel module installation

The `virtualbox-kmod.nix` and `framework-laptop-kmod.nix` overlays target
`linuxPackages_7_3`, matching the kernel selected in `essentials/boot-stuff/hardware.nix`.
VirtualBox needs `VBOX_ALLOW_MODULE_SIGNING=1` and NixOS's kernel-module make
flags; Framework needs Kbuild's `modules_install` instead of a direct file copy.
This generates the `.ko.cer` files required by the combined kernel module tree.

Verified by building the combined module tree and looking up all four signed
modules with `modinfo`:

```sh
nix build --no-link --print-out-paths path:.#nixosConfigurations.olaptop.config.system.modulesTree
```

New overlay files must be tracked by Git before using the usual Git-backed flake
rebuild. Rebuild and reboot before testing module loading; building the module
tree alone does not activate it.

## WinApps launcher GTK modules

If `winapps-launcher` reports a failure loading `appmenu-gtk-module`, check
the user GTK settings for a stale module request. The current system does not
provide that module. In `~/.config/gtk-3.0/settings.ini`, keep
`gtk-modules=colorreload-gtk-module` but remove `appmenu-gtk-module`; remove
the corresponding obsolete request from `~/.gtkrc-2.0` as well.
These are mutable Plasma-managed settings, not a WinApps package override.
Restart the launcher after changing them; no NixOS rebuild is needed.

The launcher runs as a tray application and normally stays attached to the
terminal. Use its tray menu to launch Windows or an application.
