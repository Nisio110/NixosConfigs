{

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    warn-dirty = false;
  };

  nixpkgs.config = {
    allowUnfree = true;
    auto-optimise-store = true;

    # this version of electron is EOL apparently (nixos won't rebuild unless this is set)
    permittedInsecurePackages = [ "electron-40.10.5" "pnpm-10.29.2"]; 
  };


  # Prevent dbus-broker from restarting during nixos-rebuild, which hangs
  # due to duplicate D-Bus service files from old/new store paths.
  systemd.services.dbus-broker.restartIfChanged = false;


  # See `man configuration.nix` or
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "25.11";
}
