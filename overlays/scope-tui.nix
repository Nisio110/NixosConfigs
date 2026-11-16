{
  nixpkgs.overlays = [(final: prev: {
    scope-output = prev.writeShellApplication {
      name = "scope-output";

      text = ''
        export PULSE_SOURCE="alsa_output.pci-0000_08_00.4.analog-stereo.monitor"
        exec ${prev.scope-tui}/bin/scope-tui pulse "$@"
      '';
    };
  })];
}
