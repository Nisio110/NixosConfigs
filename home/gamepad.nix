# Home-manager config for input-remapper. Deploys presets and config to
# ~/.config/input-remapper-2/.  The system-level service is enabled in
# hosts/o-nixos/input-remapper.nix.

{
  # input-remapper GUI is installed at system level (needs uinput access).
  # Config files are pure user data, so they live here.

  xdg.configFile."input-remapper-2/config.json".text = builtins.toJSON {
    version = "2.2.0";
    autoload = {
      "Xbox Wireless Controller" = "Desktop";
      "Microsoft Xbox Series S|X Controller" = "Desktop";
    };
  };

  # ── Xbox Wireless Controller ──────────────────────────────────────────

  xdg.configFile."input-remapper-2/presets/Xbox Wireless Controller/Desktop.json".text =
    builtins.toJSON [
      # Right stick → mouse axes
      {
        input_combination = [{ type = 3; code = 0; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "mouse"; output_type = 2; output_code = 0;
        mapping_type = "analog"; gain = 0.2; expo = 0.13;
      }
      {
        input_combination = [{ type = 3; code = 1; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "mouse"; output_type = 2; output_code = 1;
        mapping_type = "analog"; gain = 0.2; expo = 0.13;
      }
      # Select → Meta+g (Kando?)
      {
        input_combination = [{ type = 1; code = 314; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "KEY_LEFTMETA + g";
        mapping_type = "key_macro";
      }
      # A → left click
      {
        input_combination = [{ type = 1; code = 304; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard + mouse"; output_symbol = "BTN_LEFT";
        mapping_type = "key_macro";
      }
      # B → right click
      {
        input_combination = [{ type = 1; code = 307; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "mouse"; output_symbol = "BTN_RIGHT";
        mapping_type = "key_macro";
      }
      # Right shoulder → zoom in (Ctrl+Shift+=)
      {
        input_combination = [{ type = 1; code = 311; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "Control_L + Shift_L + KEY_EQUAL";
        mapping_type = "key_macro"; release_combination_keys = false;
      }
      # Left shoulder → zoom out (Ctrl+Shift+-)
      {
        input_combination = [{ type = 1; code = 310; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "Control_L + Shift_L + KEY_MINUS";
        mapping_type = "key_macro"; release_combination_keys = false;
      }
      # Right stick Y (axis 5) → scroll wheel
      {
        input_combination = [{ type = 3; code = 5; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "mouse"; output_type = 2; output_code = 8;
        mapping_type = "analog"; release_combination_keys = false;
        gain = 0.4; expo = 0.29;
      }
      # Start → Kando menu (Meta+Ctrl+Alt+Shift+K)
      {
        input_combination = [{ type = 1; code = 315; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard";
        output_symbol = "KEY_LEFTMETA + Control_L + Alt_L + Shift_L + K";
        mapping_type = "key_macro";
      }
      # D-pad down → next window (Meta+K)
      {
        input_combination = [{ type = 3; code = 17; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = -1; }];
        target_uinput = "keyboard"; output_symbol = "KEY_LEFTMETA + K";
        mapping_type = "key_macro";
      }
      # D-pad right → focus right (Meta+L)
      {
        input_combination = [{ type = 3; code = 16; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = 1; }];
        target_uinput = "keyboard"; output_symbol = "KEY_LEFTMETA + L";
        mapping_type = "key_macro";
      }
      # D-pad left → focus left (Meta+H)
      {
        input_combination = [{ type = 3; code = 16; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = -1; }];
        target_uinput = "keyboard"; output_symbol = "KEY_LEFTMETA + H";
        mapping_type = "key_macro";
      }
      # D-pad up → prev window (Meta+J)
      {
        input_combination = [{ type = 3; code = 17; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = 1; }];
        target_uinput = "keyboard"; output_symbol = "KEY_LEFTMETA + J";
        mapping_type = "key_macro";
      }
      # Right thumb → Ctrl+S (save)
      {
        input_combination = [{ type = 1; code = 318; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "Control_L + s";
        mapping_type = "key_macro";
      }
      # Left stick right → Alt+Right (browser forward)
      {
        input_combination = [{ type = 3; code = 10; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = 10; }];
        target_uinput = "keyboard"; output_symbol = "Alt_L + KEY_RIGHT";
        mapping_type = "key_macro";
      }
      # Left stick up → Alt+Left (browser back)
      {
        input_combination = [{ type = 3; code = 9; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = 10; }];
        target_uinput = "keyboard"; output_symbol = "Alt_L + KEY_LEFT";
        mapping_type = "key_macro";
      }
      # Left trigger → play/pause
      {
        input_combination = [{ type = 1; code = 167; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "KEY_PLAYPAUSE";
        mapping_type = "key_macro";
      }
      # Y → volume down
      {
        input_combination = [{ type = 1; code = 305; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "KEY_VOLUMEDOWN";
        mapping_type = "key_macro";
      }
      # X → volume up
      {
        input_combination = [{ type = 1; code = 308; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "KEY_VOLUMEUP";
        mapping_type = "key_macro";
      }
      # Guide → Meta (super key)
      {
        input_combination = [{ type = 1; code = 316; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "KEY_LEFTMETA";
        mapping_type = "key_macro";
      }
      # Left thumb + Right thumb → switch to Games preset
      {
        input_combination = [
          { type = 1; code = 317; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }
          { type = 1; code = 318; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }
        ];
        target_uinput = "keyboard";
        output_symbol = "KEY_LEFTMETA + Control_L + Alt_L + Shift_L + G";
        name = "Switch to games preset";
        mapping_type = "key_macro";
      }
    ];

  xdg.configFile."input-remapper-2/presets/Xbox Wireless Controller/Games.json".text =
    builtins.toJSON [
      # Guide → desktop mode shortcut (Meta+Ctrl+Alt+Shift+D)
      {
        input_combination = [{ type = 1; code = 316; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard";
        output_symbol = "KEY_LEFTCTRL + KEY_LEFTALT + KEY_LEFTMETA + KEY_LEFTSHIFT + D";
        name = "Desktop Mode - Guide Button";
        mapping_type = "key_macro";
      }
    ];

  # ── Microsoft Xbox Series S|X Controller ──────────────────────────────

  xdg.configFile."input-remapper-2/presets/Microsoft Xbox Series S_X Controller/Desktop.json".text =
    builtins.toJSON [
      # Right stick → mouse axes
      {
        input_combination = [{ type = 3; code = 0; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "mouse"; output_type = 2; output_code = 0;
        mapping_type = "analog"; gain = 0.2; expo = 0.13;
      }
      {
        input_combination = [{ type = 3; code = 1; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "mouse"; output_type = 2; output_code = 1;
        mapping_type = "analog"; gain = 0.2; expo = 0.13;
      }
      # Select → Meta+f
      {
        input_combination = [{ type = 1; code = 314; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "KEY_LEFTMETA + f";
        mapping_type = "key_macro";
      }
      # A → left click
      {
        input_combination = [{ type = 1; code = 304; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard + mouse"; output_symbol = "BTN_LEFT";
        mapping_type = "key_macro";
      }
      # B → right click
      {
        input_combination = [{ type = 1; code = 307; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "mouse"; output_symbol = "BTN_RIGHT";
        mapping_type = "key_macro";
      }
      # Right shoulder → zoom in (Ctrl+Shift+=)
      {
        input_combination = [{ type = 1; code = 311; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "Control_L + Shift_L + KEY_EQUAL";
        mapping_type = "key_macro"; release_combination_keys = false;
      }
      # Left shoulder → zoom out (Ctrl+Shift+-)
      {
        input_combination = [{ type = 1; code = 310; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "Control_L + Shift_L + KEY_MINUS";
        mapping_type = "key_macro"; release_combination_keys = false;
      }
      # Right stick Y (axis 5) → scroll wheel
      {
        input_combination = [{ type = 3; code = 5; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "mouse"; output_type = 2; output_code = 8;
        mapping_type = "analog"; release_combination_keys = false;
        gain = 0.4; expo = 0.29;
      }
      # Start → Kando menu (Meta+Ctrl+Alt+Shift+K)
      {
        input_combination = [{ type = 1; code = 315; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard";
        output_symbol = "KEY_LEFTMETA + Control_L + Alt_L + Shift_L + K";
        mapping_type = "key_macro";
      }
      # D-pad down → next window (Meta+K)
      {
        input_combination = [{ type = 3; code = 17; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = -1; }];
        target_uinput = "keyboard"; output_symbol = "KEY_LEFTMETA + K";
        mapping_type = "key_macro";
      }
      # D-pad right → focus right (Meta+L)
      {
        input_combination = [{ type = 3; code = 16; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = 1; }];
        target_uinput = "keyboard"; output_symbol = "KEY_LEFTMETA + L";
        mapping_type = "key_macro";
      }
      # D-pad left → focus left (Meta+H)
      {
        input_combination = [{ type = 3; code = 16; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = -1; }];
        target_uinput = "keyboard"; output_symbol = "KEY_LEFTMETA + H";
        mapping_type = "key_macro";
      }
      # D-pad up → prev window (Meta+J)
      {
        input_combination = [{ type = 3; code = 17; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = 1; }];
        target_uinput = "keyboard"; output_symbol = "KEY_LEFTMETA + J";
        mapping_type = "key_macro";
      }
      # Right thumb → Ctrl+S (save)
      {
        input_combination = [{ type = 1; code = 318; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "Control_L + s";
        mapping_type = "key_macro";
      }
      # Left trigger → Meta+g (Kando?)
      {
        input_combination = [{ type = 1; code = 167; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "KEY_LEFTMETA + g";
        mapping_type = "key_macro";
      }
      # Y → volume down
      {
        input_combination = [{ type = 1; code = 305; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "KEY_VOLUMEDOWN";
        mapping_type = "key_macro";
      }
      # X → volume up
      {
        input_combination = [{ type = 1; code = 308; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "KEY_VOLUMEUP";
        mapping_type = "key_macro";
      }
      # Guide → Meta (super key)
      {
        input_combination = [{ type = 1; code = 316; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }];
        target_uinput = "keyboard"; output_symbol = "KEY_LEFTMETA";
        mapping_type = "key_macro";
      }
      # Left thumb + Right thumb + left stick down + right stick down → lock screen shortcut
      {
        input_combination = [
          { type = 1; code = 318; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }
          { type = 1; code = 317; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }
          { type = 3; code = 10; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = -1; }
          { type = 3; code = 9; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = -1; }
        ];
        target_uinput = "keyboard";
        output_symbol = "KEY_LEFTMETA + KEY_LEFTCTRL + KEY_LEFTSHIFT";
        mapping_type = "key_macro";
      }
      # Left thumb + Right thumb → switch to Games preset
      {
        input_combination = [
          { type = 1; code = 318; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }
          { type = 1; code = 317; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }
        ];
        target_uinput = "keyboard";
        output_symbol = "KEY_LEFTMETA + KEY_LEFTCTRL + KEY_LEFTALT + KEY_LEFTSHIFT + G";
        name = "Switch to games preset";
        mapping_type = "key_macro";
      }
      # Left thumb + Right thumb + left stick up + right stick up → another shortcut
      {
        input_combination = [
          { type = 1; code = 317; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }
          { type = 1; code = 318; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }
          { type = 3; code = 10; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = -1; }
          { type = 3; code = 9; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; analog_threshold = -1; }
        ];
        target_uinput = "keyboard";
        output_symbol = "KEY_LEFTMETA + Control_L + Alt_L + Shift_L + G";
        mapping_type = "key_macro";
      }
    ];

  xdg.configFile."input-remapper-2/presets/Microsoft Xbox Series S_X Controller/Games.json".text =
    builtins.toJSON [
      # Left thumb + Right thumb → desktop mode shortcut (Meta+Ctrl+Alt+Shift+D)
      {
        input_combination = [
          { type = 1; code = 317; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }
          { type = 1; code = 318; origin_hash = "fd59f7bcef9cde578fc75b2279c2741d"; }
        ];
        target_uinput = "keyboard";
        output_symbol = "KEY_LEFTMETA + Control_L + Alt_L + Shift_L + D";
        mapping_type = "key_macro";
      }
    ];
}
