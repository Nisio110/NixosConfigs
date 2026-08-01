{lib, ...}:
let
  # Mod+N focuses workspace N, Mod+Shift+N moves the column there.
  workspaceBinds = lib.mergeAttrsList (map (n: {
    "Mod+${toString n}".action.focus-workspace = n;
    "Mod+Shift+${toString n}".action.move-column-to-workspace = n;
  }) (lib.range 1 5));

  # Mod+<key> focuses, Mod+Shift+<key> moves. Columns are horizontal, windows vertical.
  motionBinds = lib.mergeAttrsList (lib.mapAttrsToList (key: dir: {
    "Mod+${key}".action."focus-${dir}" = [ ];
    "Mod+Shift+${key}".action."move-${dir}" = [ ];
  }) {
    H = "column-left";
    L = "column-right";
    K = "window-up";
    J = "window-down";
    Left = "column-left";
    Right = "column-right";
    Up = "window-up";
    Down = "window-down";
  });

  setVolume = arg: [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" arg ];
  toggleMute = node: [ "wpctl" "set-mute" node "toggle" ];
in
{
  programs.niri.settings = {
    input.keyboard.xkb = {
      layout = "gb";
      variant = "mac";
    };

    spawn-at-startup = [
      { argv = [ "waybar" ]; }
      { argv = [ "mako" ]; }
    ];

    binds = {
      "Mod+T".action.spawn = "kitty";
      "Mod+D".action.spawn = "fuzzel";
      "Mod+Q".action.close-window = [ ];
      "Mod+F".action.maximize-column = [ ];
      "Mod+Shift+F".action.fullscreen-window = [ ];

      "Print".action.screenshot = [ ];
      "Mod+Shift+S".action.screenshot-screen = [ ];

      "Mod+Shift+E".action.quit = [ ];
      "Mod+Shift+P".action.power-off-monitors = [ ];

      "XF86AudioRaiseVolume".action.spawn = setVolume "0.1+";
      "XF86AudioLowerVolume".action.spawn = setVolume "0.1-";
      "XF86AudioMute".action.spawn = toggleMute "@DEFAULT_AUDIO_SINK@";
      "XF86AudioMicMute".action.spawn = toggleMute "@DEFAULT_AUDIO_SOURCE@";
    }
    // motionBinds
    // workspaceBinds;
  };
}
