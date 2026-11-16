{ lib, pkgs, homeDir, ... }:
let
  p = import ./_palette.nix;

  # One radius for everything the compositor draws, so windows, the bar,
  # notifications and the launcher all agree on their shape.
  radius = 12.0;
  corners = lib.genAttrs [ "top-left" "top-right" "bottom-right" "bottom-left" ] (_: radius);

  # Same image the Plasma session uses, so both sessions look like one machine.
  wallpaper = "${homeDir}/.local/share/wallpapers/macos-space/macos-space-1.jpg";

  # Layer-shell namespaces of the session shell: waybar, mako, fuzzel.
  shellLayers = map (namespace: { inherit namespace; }) [
    "^waybar$"
    "^notifications$"
    "^launcher$"
  ];

  # Mod+N focuses workspace N, Mod+Shift+N moves the column there.
  workspaceBinds = lib.mergeAttrsList (map (n: {
    "Mod+${toString n}".action.focus-workspace = n;
    "Mod+Shift+${toString n}".action.move-column-to-workspace = n;
  }) (lib.range 1 5));

  # Mod+<key> focuses, Mod+Shift+<key> moves. Columns are horizontal, windows
  # vertical. J/K are workspaces (below), so windows within a column live on
  # the arrow keys.
  motionBinds = lib.mergeAttrsList (lib.mapAttrsToList (key: dir: {
    "Mod+${key}".action."focus-${dir}" = [ ];
    "Mod+Shift+${key}".action."move-${dir}" = [ ];
  }) {
    H = "column-left";
    L = "column-right";
    Left = "column-left";
    Right = "column-right";
    Up = "window-up";
    Down = "window-down";
  });

  # Mod+K/J walk workspaces; Mod+Shift takes the focused column along.
  workspaceMotionBinds = lib.mergeAttrsList (lib.mapAttrsToList (key: dir: {
    "Mod+${key}".action."focus-workspace-${dir}" = [ ];
    "Mod+Shift+${key}".action."move-column-to-workspace-${dir}" = [ ];
  }) {
    K = "up";
    J = "down";
  });

  # Mod+scroll walks columns, Mod+Shift+scroll walks workspaces. Wheel events
  # repeat far faster than a keypress, hence the cooldown.
  scrollBinds = lib.mapAttrs (_: action: { inherit action; cooldown-ms = 120; }) {
    "Mod+WheelScrollRight".focus-column-right = [ ];
    "Mod+WheelScrollLeft".focus-column-left = [ ];
    "Mod+WheelScrollDown".focus-workspace-down = [ ];
    "Mod+WheelScrollUp".focus-workspace-up = [ ];
  };

  setVolume = arg: [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" arg ];
  toggleMute = node: [ "wpctl" "set-mute" node "toggle" ];
in
{
  programs.niri.settings = {
    input.keyboard.xkb = {
      layout = "gb";
      variant = "mac";
    };

    # Physical layout, mirroring the Plasma session (kwinoutputconfig.json):
    # the AOC is wall-mounted in portrait to the right of the LG, whose top
    # edge sits 730px down so the two panels line up as they do on the desk.
    #
    # Keyed by make/model/serial rather than connector so a different DP port
    # doesn't silently drop the layout.
    outputs = {
      # LG UltraGear (DP-3) — landscape, primary.
      "LG Electronics LG ULTRAGEAR 508BNVL2Q775" = {
        mode = { width = 2560; height = 1440; refresh = 200.0; };
        position = { x = 0; y = 730; };
        focus-at-startup = true;
      };

      # AOC Q27G2G3R3B (DP-2) — portrait. niri's rotation is counter-clockwise,
      # matching KWin's Rotated90. It defaults to its 60 Hz "preferred" mode,
      # so the 165 Hz mode has to be named explicitly.
      "PNP(AOC) Q27G2G3R3B RTEN3HA013760" = {
        mode = { width = 2560; height = 1440; refresh = 165.0; };
        transform.rotation = 90;
        position = { x = 2560; y = 0; };
      };
    };

    # Rootless Xwayland for X11-only clients. niri probes the binary for
    # -listenfd support and manages its lifecycle itself, so it must not
    # also be in spawn-at-startup.
    xwayland-satellite = {
      enable = true;
      path = lib.getExe pkgs.xwayland-satellite;
    };

    # waybar and mako run as systemd user services bound to niri.service
    # (see waybar.nix / mako.nix); only swaybg is spawned here.
    spawn-at-startup = [
      { argv = [ (lib.getExe pkgs.swaybg) "--mode" "fill" "--image" wallpaper "--color" p.base ]; }
    ];

    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;
    screenshot-path = "${homeDir}/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    cursor = {
      # Matches the Plasma session (home.pointerCursor in ../plasma.nix).
      theme = "Bibata-Modern-Ice";
      size = 24;
      hide-when-typing = true;
      hide-after-inactive-ms = 10000;
    };

    layout = {
      gaps = 12;
      # Transparent so the wallpaper in the backdrop (see the swaybg layer rule
      # below) shows through on normal workspaces, not just in the overview.
      # p.base is the fallback niri paints when swaybg isn't running.
      background-color = "transparent";

      # A lone window sits centred instead of glued to the left edge.
      always-center-single-column = true;
      empty-workspace-above-first = true;

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];
      default-column-width.proportion = 0.5;

      # Focus ring only — a border as well would double the outline.
      focus-ring = {
        enable = true;
        width = 2;
        active.gradient = {
          from = p.green;
          to = p.aqua;
          angle = 45;
          relative-to = "workspace-view";
        };
        inactive.color = p.surface1;
        urgent.color = p.red;
      };
      border.enable = false;

      shadow = {
        enable = true;
        softness = 30;
        spread = 3;
        offset = { x = 0; y = 6; };
        draw-behind-window = false;
        color = "#0b0f11b3";
        inactive-color = "#0b0f1166";
      };

      insert-hint.display.gradient = {
        from = "#cbe3b380";
        to = "#b3e3ca80";
        angle = 45;
        relative-to = "workspace-view";
      };

      tab-indicator = {
        enable = true;
        hide-when-single-tab = true;
        place-within-column = true;
        position = "left";
        corner-radius = 4.0;
        gap = 6.0;
        gaps-between-tabs = 4.0;
        width = 4.0;
        length.total-proportion = 0.6;
        active.color = p.green;
        inactive.color = p.surface1;
        urgent.color = p.red;
      };

      # Keep the focused column clear of the (floating) bar and screen edges.
      struts = {
        left = 4;
        right = 4;
        top = 0;
        bottom = 4;
      };
    };

    overview = {
      zoom = 0.45;
      backdrop-color = p.crust;
      workspace-shadow = {
        enable = true;
        softness = 40;
        spread = 10;
        offset = { x = 0; y = 0; };
        color = "#0b0f11cc";
      };
    };

    animations = {
      slowdown = 0.85;
      window-open.kind.easing = {
        curve = "ease-out-expo";
        duration-ms = 200;
      };
      window-close.kind.easing = {
        curve = "ease-out-quad";
        duration-ms = 150;
      };
      workspace-switch.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 1000;
        epsilon = 0.0001;
      };
      horizontal-view-movement.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 800;
        epsilon = 0.0001;
      };
    };

    gestures.hot-corners.enable = false;

    window-rules = [
      # Round every window, clipping the surface itself and not just the
      # decorations, so corners look cut rather than merely outlined.
      {
        geometry-corner-radius = corners;
        clip-to-geometry = true;
        draw-border-with-background = false;
      }

      # Transient UI is more useful floating than wedged into the scroll.
      {
        matches = [
          { app-id = "^org\\.kde\\.polkit-kde-authentication-agent-1$"; }
          { app-id = "^xdg-desktop-portal-gtk$"; }
          { app-id = "^pavucontrol$"; }
          { app-id = "^org\\.pulseaudio\\.pavucontrol$"; }
          { app-id = "^\\.blueman-manager-wrapped$"; }
          { title = "^(Open|Save)( File| Folder| As|)\\b"; }
        ];
        open-floating = true;
      }

      # Picture-in-picture parks itself bottom-right and never steals focus.
      {
        matches = [ { title = "^Picture-in-Picture$"; } ];
        open-floating = true;
        open-focused = false;
        default-floating-position = {
          x = 32;
          y = 32;
          relative-to = "bottom-right";
        };
      }

      # Content-heavy apps want more than half a screen by default.
      {
        matches = [
          { app-id = "^zen-beta$"; }
          { app-id = "^obsidian$"; }
          { app-id = "^libreoffice"; }
        ];
        default-column-width.proportion = 0.66667;
      }
    ];

    layer-rules = [
      # Put the wallpaper in the backdrop so it stays visible in the overview
      # and between workspaces instead of a flat colour.
      {
        matches = [ { namespace = "^wallpaper$"; } ];
        place-within-backdrop = true;
      }

      # Bar, notifications and launcher get the same rounded silhouette and
      # drop shadow as windows.
      {
        matches = shellLayers;
        geometry-corner-radius = corners;
        shadow = {
          enable = true;
          softness = 24;
          spread = 2;
          offset = { x = 0; y = 4; };
          color = "#0b0f11cc";
        };
      }
    ];

    binds = {
      "Mod+T".action.spawn = "kitty";
      # niri can't bind a bare Mod: binds fire on press, and the modifier state
      # it matches against already has Super set by the time Super_L arrives.
      "Mod+Space".action.spawn = "fuzzel";
      "Mod+Q".action.close-window = [ ];
      "Mod+F".action.maximize-column = [ ];
      "Mod+Shift+F".action.fullscreen-window = [ ];
      "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];

      # Overview: the zoomed-out view of every workspace.
      "Mod+O" = {
        action.toggle-overview = [ ];
        repeat = false;
      };

      # Floating layer.
      "Mod+V".action.toggle-window-floating = [ ];
      "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];

      # Column shape: tabs, presets, fine adjustment, centring.
      "Mod+W".action.toggle-column-tabbed-display = [ ];
      "Mod+C".action.center-column = [ ];
      "Mod+R".action.switch-preset-column-width = [ ];
      "Mod+Shift+R".action.switch-preset-window-height = [ ];
      "Mod+Ctrl+R".action.reset-window-height = [ ];
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # Move windows between columns.
      "Mod+Comma".action.consume-window-into-column = [ ];
      "Mod+Period".action.expel-window-from-column = [ ];
      "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
      "Mod+BracketRight".action.consume-or-expel-window-right = [ ];

      # Workspaces beyond the numbered binds (up/down live on Mod+K/J).
      "Mod+Tab".action.focus-workspace-previous = [ ];
      "Mod+Home".action.focus-column-first = [ ];
      "Mod+End".action.focus-column-last = [ ];

      "Print".action.screenshot = [ ];
      "Alt+Print".action.screenshot-window = [ ];
      "Mod+Shift+S".action.screenshot-screen = [ ];

      "Mod+Shift+E".action.quit = [ ];
      "Mod+Shift+P".action.power-off-monitors = [ ];

      "XF86AudioRaiseVolume".action.spawn = setVolume "0.1+";
      "XF86AudioLowerVolume".action.spawn = setVolume "0.1-";
      "XF86AudioMute".action.spawn = toggleMute "@DEFAULT_AUDIO_SINK@";
      "XF86AudioMicMute".action.spawn = toggleMute "@DEFAULT_AUDIO_SOURCE@";
    }
    // motionBinds
    // workspaceMotionBinds
    // scrollBinds
    // workspaceBinds;
  };
}
