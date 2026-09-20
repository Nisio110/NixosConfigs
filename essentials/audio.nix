{
  # Sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;

    extraConfig.pipewire."echo-cancel" = {
      "context.modules" = [
        { name = "libpipewire-module-echo-cancel";
          args = {
            "monitor.mode" = true;
            "capture.props" = {
              "node.name" = "Echo Cancellation Capture";
            };
            "source.props" = {
              "node.name" = "Echo Cancellation Source";
            };
            "sink.props" = {
              "node.name" = "Echo Cancellation Sink";
            };
            "playback.props" = {
              "node.name" = "Echo Cancellation Playback";
            };
          };
        }
      ];
    };
  };
}
