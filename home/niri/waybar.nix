{ lib, ... }:
let
  p = import ./_palette.nix;

  # Expose the palette to GTK CSS so the stylesheet has one source of truth
  # and can use alpha() on named colours.
  paletteCss = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (name: hex: "@define-color ${name} ${hex};") p
  );
in
{
  programs.waybar = {
    enable = true;
    # Bound to niri.service rather than graphical-session.target: Plasma
    # activates the generic target too, and the bar must only run under niri.
    # It starts/stops with the compositor and restarts on failure.
    systemd = {
      enable = true;
      targets = [ "niri.service" ];
    };

    settings.main = {
      layer = "top";
      position = "top";
      height = 34;
      spacing = 0;
      # Floating bar: niri's layer rule rounds and shadows this rectangle.
      margin-top = 8;
      margin-left = 12;
      margin-right = 12;

      modules-left = [ "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "cpu" "memory" "network" "pulseaudio" "idle_inhibitor" "tray" ];

      "niri/workspaces" = {
        format = "{index}";
        all-outputs = false;
      };

      "niri/window" = {
        format = "{title}";
        separate-outputs = true;
        max-length = 70;
        rewrite = {
          "(.*) — Zen Browser" = "󰖟  $1";
          "(.*) - Obsidian.*" = "󰠮  $1";
        };
      };

      clock = {
        format = "󰥔  {:%H:%M}";
        format-alt = "󰃭  {:%a %d %b}";
        tooltip-format = "<tt>{calendar}</tt>";
        calendar = {
          mode = "month";
          format = {
            today = "<span color='${p.green}'><b>{}</b></span>";
            weekdays = "<span color='${p.yellow}'>{}</span>";
          };
        };
      };

      cpu = {
        interval = 5;
        format = "󰻠  {usage}%";
        states.critical = 90;
      };

      memory = {
        interval = 5;
        format = "󰍛  {percentage}%";
        tooltip-format = "{used:0.1f}G of {total:0.1f}G";
        states.critical = 90;
      };

      network = {
        interval = 5;
        format-wifi = "󰖩  {essid}";
        format-ethernet = "󰈀  {ifname}";
        format-disconnected = "󰖪  offline";
        tooltip-format = "{ifname}  {ipaddr}";
      };

      pulseaudio = {
        format = "{icon}  {volume}%";
        format-muted = "󰝟  muted";
        format-icons.default = [ "󰕿" "󰖀" "󰕾" ];
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
        on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
        tooltip-format = "{desc}";
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "󰅶";
          deactivated = "󰛊";
        };
      };

      tray = {
        icon-size = 16;
        spacing = 10;
      };
    };

    style = ''
      ${paletteCss}

      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: "Overpass Nerd Font", "JetBrainsMono Nerd Font", sans-serif;
        font-size: 13px;
        font-weight: 500;
      }

      window#waybar {
        background: alpha(@crust, 0.92);
        border: 1px solid alpha(@surface1, 0.9);
        border-radius: 12px;
        color: @text;
      }

      .modules-left,
      .modules-center,
      .modules-right {
        padding: 0 6px;
      }

      #workspaces button {
        padding: 0 9px;
        margin: 4px 2px;
        color: @subtle;
        background: transparent;
        border-radius: 8px;
        transition: background-color 150ms ease, color 150ms ease;
      }

      #workspaces button.empty {
        color: @muted;
      }

      #workspaces button:hover {
        background: alpha(@surface1, 0.8);
        color: @text;
      }

      #workspaces button.active {
        background: alpha(@surface0, 0.9);
        color: @text;
      }

      #workspaces button.focused {
        background: @green;
        color: @crust;
      }

      #workspaces button.urgent {
        background: @red;
        color: @crust;
      }

      #window {
        color: @subtle;
        padding: 0 10px;
      }

      window#waybar.empty #window {
        padding: 0;
      }

      #clock {
        color: @text;
        font-weight: 600;
        padding: 0 12px;
      }

      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #idle_inhibitor {
        padding: 0 10px;
        margin: 4px 2px;
        border-radius: 8px;
        background: alpha(@surface0, 0.75);
      }

      #cpu { color: @aqua; }
      #memory { color: @purple; }
      #network { color: @blue; }
      #pulseaudio { color: @yellow; }
      #idle_inhibitor { color: @muted; }

      #idle_inhibitor.activated { color: @green; }
      #pulseaudio.muted { color: @muted; }
      #network.disconnected { color: @red; }

      #cpu.critical,
      #memory.critical {
        background: alpha(@red, 0.2);
        color: @red;
      }

      #tray {
        padding: 0 8px;
        margin: 4px 2px;
      }

      #tray > .passive { -gtk-icon-effect: dim; }
      #tray > .needs-attention { -gtk-icon-effect: highlight; }

      tooltip {
        background: @crust;
        border: 1px solid @surface1;
        border-radius: 10px;
      }

      tooltip label {
        color: @text;
        padding: 4px;
      }
    '';
  };
}
