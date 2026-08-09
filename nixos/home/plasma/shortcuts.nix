# Global shortcuts (kglobalshortcutsrc). The kwin group lives in ./kwin.nix.
{
  programs.plasma.shortcuts = {
    ActivityManager = {
      switch-to-activity-7a5c152a-e224-4d67-a50f-b6ba8dbc59ae = [ ];
      switch-to-activity-f52be7b1-a151-4a8f-868e-04b3b3e30626 = [ ];
    };
    "KDE Keyboard Layout Switcher" = {
      "Switch keyboard layout to English (Macintosh)" = [ ];
      "Switch keyboard layout to English (UK, Macintosh)" = [ ];
      "Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
      "Switch to Next Keyboard Layout" = "Meta+Alt+K";
    };
    kaccess."Toggle Screen Reader On and Off" = [ ];
    kando.scripts-menu = [ ];
    kmix = {
      decrease_microphone_volume = "Microphone Volume Down";
      decrease_volume = "Volume Down";
      decrease_volume_small = "Shift+Volume Down";
      increase_microphone_volume = "Microphone Volume Up";
      increase_volume = "Volume Up";
      increase_volume_small = "Shift+Volume Up";
      mic_mute = ["Microphone Mute" "Meta+Volume Mute"];
      mute = "Volume Mute";
    };
    ksmserver = {
      "Halt Without Confirmation" = [ ];
      "Lock Session" = "Meta+Ctrl+Alt+L";
      "Log Out" = [ ];
      "Log Out Without Confirmation" = "Meta+Ctrl+Alt+Shift+L";
      LogOut = [ ];
      Reboot = [ ];
      "Reboot Without Confirmation" = [ ];
      "Shut Down" = [ ];
    };
    mediacontrol = {
      mediavolumedown = ["Alt+J" "Alt+K"];
      mediavolumeup = [ ];
      nextmedia = "Media Next";
      pausemedia = "Media Pause";
      playmedia = [ ];
      playpausemedia = "Media Play";
      previousmedia = "Media Previous";
      seekbackwardmedia = "Media Rewind";
      seekbackwardmedialong = [ ];
      seekforwardmedia = "Media Fast Forward";
      seekforwardmedialong = [ ];
      stopmedia = "Media Stop";
    };
    org_kde_powerdevil = {
      "Decrease Keyboard Brightness" = "Keyboard Brightness Down";
      "Decrease Screen Brightness" = "Monitor Brightness Down";
      "Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
      Hibernate = "Hibernate";
      "Increase Keyboard Brightness" = "Keyboard Brightness Up";
      "Increase Screen Brightness" = "Monitor Brightness Up";
      "Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
      PowerDown = "Power Down";
      PowerOff = "Power Off";
      Sleep = "Sleep";
      "Toggle Keyboard Backlight" = "Keyboard Light On/Off";
      "Turn Off Screen" = [ ];
      powerProfile = ["Battery" "Meta+B"];
    };
    plasmashell = {
      "Slideshow Wallpaper Next Image" = [ ];
      "activate application launcher" = ["Alt+F1" "Meta+Space"];
      "activate task manager entry 1" = "Meta+1";
      "activate task manager entry 10" = [ ];
      "activate task manager entry 2" = "Meta+2";
      "activate task manager entry 3" = "Meta+3";
      "activate task manager entry 4" = "Meta+4";
      "activate task manager entry 5" = "Meta+5";
      "activate task manager entry 6" = "Meta+6";
      "activate task manager entry 7" = "Meta+7";
      "activate task manager entry 8" = "Meta+8";
      "activate task manager entry 9" = "Meta+9";
      clear-history = [ ];
      clipboard_action = "Meta+Ctrl+X";
      cycle-panels = "Meta+Alt+P";
      cycleNextAction = [ ];
      cyclePrevAction = [ ];
      edit_clipboard = [ ];
      "manage activities" = "Alt+Q";
      "next activity" = "Meta+A";
      "previous activity" = "Meta+Shift+A";
      repeat_action = [ ];
      "show dashboard" = "Ctrl+F12";
      show-barcode = [ ];
      show-on-mouse-pos = "Meta+V";
      "stop current activity" = [ ];
      "switch to next activity" = [ ];
      "switch to previous activity" = [ ];
      "toggle do not disturb" = [ ];
    };
    "services/kitty.desktop"._launch = "F12";
    "services/net.local.open-btop.sh.desktop"._launch = "Ctrl+Shift+Esc";
    "services/net.local.switch_to_games.sh.desktop"._launch = "Meta+Ctrl+Alt+Shift+G";
    "services/net.local.toggle-vkbd.sh.desktop"._launch = "Meta+Ctrl+Alt+Shift+K";
    "services/net.local.xbox-desktop.sh.desktop"._launch = "Meta+Ctrl+Alt+Shift+D";
    "services/org.kde.dolphin.desktop"._launch = [ ];
    "services/org.kde.konsole.desktop"._launch = [ ];
    "services/org.kde.krunner.desktop"._launch = "Meta";
    "services/org.kde.kscreen.desktop".ShowOSD = "Meta+P";
    "services/org.kde.plasma.emojier.desktop"._launch = "Meta+.";
    "services/org.kde.spectacle.desktop" = {
      RectangularRegionScreenShot = ["Meta+Shift+S" "Meta+Shift+Print"];
      _launch = "Print";
    };
    "services/org.wezfurlong.wezterm.desktop"._launch = "F12";
    "services/systemsettings.desktop"._launch = ["Tools" ""];
    "services/thunar.desktop"._launch = "Meta+E";
  };
}
