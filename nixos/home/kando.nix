{ config, lib, ... }:
let
  kandoDir = "${config.home.homeDirectory}/.config/kando";
in
{
  # kando needs to write back to these files at runtime (menu saves, etc.)
  # xdg.configFile would create read-only store symlinks — use activation seed instead.
  # Conditional: only install if the file is absent, so UI changes survive rebuilds.
  home.activation.kandoSeed = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p ${lib.escapeShellArg kandoDir}
    if [ ! -f ${lib.escapeShellArg "${kandoDir}/config.json"} ]; then
      run install -m644 ${./kando/config.json} ${lib.escapeShellArg "${kandoDir}/config.json"}
    fi
    if [ ! -f ${lib.escapeShellArg "${kandoDir}/menus.json"} ]; then
      run install -m644 ${./kando/menus.json} ${lib.escapeShellArg "${kandoDir}/menus.json"}
    fi
  '';
}
