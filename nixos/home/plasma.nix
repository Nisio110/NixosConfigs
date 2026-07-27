{ pkgs, lib, inputs, ... }:
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.plasma = let 
      wallpaper = "/home/oisin/.local/share/wallpapers/macos-space/macos-space-1.jpg";
    in {
    enable = true;

    fonts = {
      general = { family = "Overpass"; pointSize = 10; };
      fixedWidth = { family = "Overpass Mono"; pointSize = 10; };
    };
    
    workspace = {
      cursor = { theme = "Bibata-Modern-Ice"; size = 24; };
      inherit wallpaper;
    };

    kscreenlocker = {
      appearance.wallpaper = wallpaper;
      autoLock = true;
      timeout = 120; # minutes
    };

    krunner = {
      position = "top";
      historyBehavior = "enableAutoComplete";
    };

    shortcuts = {
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
      kwin = {
        "Activate Window Demanding Attention" = "Meta+Ctrl+A";
        ClearLastMouseMark = "Meta+Shift+F12";
        ClearMouseMarks = "Meta+Shift+F11";
        Cube = "Meta+C";
        "Cycle Overview" = [ ];
        "Cycle Overview Opposite" = [ ];
        "Decrease Opacity" = [ ];
        "Edit Tiles" = "Meta+T";
        Expose = "Ctrl+F9";
        ExposeAll = ["Ctrl+F10" "Launch (C)"];
        ExposeClass = "Ctrl+F7";
        ExposeClassCurrentDesktop = [ ];
        "Grid View" = "Meta+G";
        "Increase Opacity" = [ ];
        "KZones: Activate layout 1" = "Meta+Num+1";
        "KZones: Activate layout 2" = "Meta+Num+2";
        "KZones: Activate layout 3" = "Meta+Num+3";
        "KZones: Activate layout 4" = "Meta+Num+4";
        "KZones: Activate layout 5" = "Meta+Num+5";
        "KZones: Activate layout 6" = "Meta+Num+6";
        "KZones: Activate layout 7" = "Meta+Num+7";
        "KZones: Activate layout 8" = "Meta+Num+8";
        "KZones: Activate layout 9" = "Meta+Num+9";
        "KZones: Cycle layouts" = "Ctrl+Alt+D";
        "KZones: Cycle layouts (reversed)" = "Ctrl+Alt+Shift+D";
        "KZones: Move active window down" = [ ];
        "KZones: Move active window left" = [ ];
        "KZones: Move active window right" = [ ];
        "KZones: Move active window to next zone" = "Ctrl+Alt+Right";
        "KZones: Move active window to previous zone" = "Ctrl+Alt+Left";
        "KZones: Move active window to zone 1" = "Ctrl+Alt+Num+1";
        "KZones: Move active window to zone 2" = "Ctrl+Alt+Num+2";
        "KZones: Move active window to zone 3" = "Ctrl+Alt+Num+3";
        "KZones: Move active window to zone 4" = "Ctrl+Alt+Num+4";
        "KZones: Move active window to zone 5" = "Ctrl+Alt+Num+5";
        "KZones: Move active window to zone 6" = "Ctrl+Alt+Num+6";
        "KZones: Move active window to zone 7" = "Ctrl+Alt+Num+7";
        "KZones: Move active window to zone 8" = "Ctrl+Alt+Num+8";
        "KZones: Move active window to zone 9" = "Ctrl+Alt+Num+9";
        "KZones: Move active window up" = [ ];
        "KZones: Snap active window" = "Meta+Shift+Space";
        "KZones: Snap all windows" = [ ];
        "KZones: Switch to next window in current zone" = "Ctrl+Alt+Up";
        "KZones: Switch to previous window in current zone" = "Ctrl+Alt+Down";
        "KZones: Toggle zone overlay" = "Ctrl+Alt+C";
        "Kill Window" = "Meta+Q";
        KrohnkiteBTreeLayout = [ ];
        KrohnkiteColumnsLayout = [ ];
        KrohnkiteDecrease = [ ];
        KrohnkiteFloatAll = "Meta+Shift+F";
        KrohnkiteFloatingLayout = "Meta+Ctrl+F";
        KrohnkiteFocusDown = [ ];
        KrohnkiteFocusLeft = [ ];
        KrohnkiteFocusNext = [ ];
        KrohnkiteFocusPrev = "Meta+\\";
        KrohnkiteFocusRight = [ ];
        KrohnkiteFocusUp = [ ];
        KrohnkiteGrowHeight = [ ];
        KrohnkiteIncrease = "Meta+I";
        KrohnkiteMonocleLayout = "Meta+Ctrl+M";
        KrohnkiteNextLayout = "Meta+`";
        KrohnkitePreviousLayout = "Meta+~";
        KrohnkiteQuarterLayout = [ ];
        KrohnkiteRotate = [ ];
        KrohnkiteRotatePart = [ ];
        KrohnkiteSetMaster = "Meta+Return";
        KrohnkiteShiftDown = "Meta+Shift+J";
        KrohnkiteShiftLeft = "Meta+Shift+H";
        KrohnkiteShiftRight = "Meta+Shift+L";
        KrohnkiteShiftUp = "Meta+Shift+K";
        KrohnkiteShrinkHeight = [ ];
        KrohnkiteShrinkWidth = [ ];
        KrohnkiteSpiralLayout = [ ];
        KrohnkiteSpreadLayout = [ ];
        KrohnkiteStackedLayout = [ ];
        KrohnkiteStairLayout = [ ];
        KrohnkiteTileLayout = "Meta+Ctrl+T";
        KrohnkiteToggleFloat = [ ];
        KrohnkiteTreeColumnLayout = [ ];
        KrohnkitegrowWidth = [ ];
        KrohnkitetoggleDock = [ ];
        "Move Tablet to Next LogicalOutput" = [ ];
        "Move Tablet to Next Output" = [ ];
        MoveMouseToCenter = "Meta+F6";
        MoveMouseToFocus = "Meta+F5";
        MoveZoomDown = [ ];
        MoveZoomLeft = [ ];
        MoveZoomRight = [ ];
        MoveZoomUp = [ ];
        Overview = "Meta+S";
        "Setup Window Shortcut" = [ ];
        "Show Desktop" = "Meta+D";
        "Suspend Compositing" = "Alt+Shift+F12";
        "Switch One Desktop Down" = "Meta+J";
        "Switch One Desktop Up" = "Meta+K";
        "Switch One Desktop to the Left" = "Meta+H";
        "Switch One Desktop to the Right" = "Meta+L";
        "Switch Window Down" = "Meta+Alt+Down";
        "Switch Window Left" = "Meta+Alt+Left";
        "Switch Window Right" = "Meta+Alt+Right";
        "Switch Window Up" = "Meta+Alt+Up";
        "Switch to Desktop 1" = "Ctrl+F1";
        "Switch to Desktop 10" = [ ];
        "Switch to Desktop 11" = [ ];
        "Switch to Desktop 12" = [ ];
        "Switch to Desktop 13" = [ ];
        "Switch to Desktop 14" = [ ];
        "Switch to Desktop 15" = [ ];
        "Switch to Desktop 16" = [ ];
        "Switch to Desktop 17" = [ ];
        "Switch to Desktop 18" = [ ];
        "Switch to Desktop 19" = [ ];
        "Switch to Desktop 2" = "Ctrl+F2";
        "Switch to Desktop 20" = [ ];
        "Switch to Desktop 21" = [ ];
        "Switch to Desktop 22" = [ ];
        "Switch to Desktop 23" = [ ];
        "Switch to Desktop 24" = [ ];
        "Switch to Desktop 25" = [ ];
        "Switch to Desktop 3" = "Ctrl+F3";
        "Switch to Desktop 4" = "Ctrl+F4";
        "Switch to Desktop 5" = [ ];
        "Switch to Desktop 6" = [ ];
        "Switch to Desktop 7" = [ ];
        "Switch to Desktop 8" = [ ];
        "Switch to Desktop 9" = [ ];
        "Switch to Next Desktop" = [ ];
        "Switch to Next Screen" = [ ];
        "Switch to Previous Desktop" = [ ];
        "Switch to Previous Screen" = [ ];
        "Switch to Screen 0" = [ ];
        "Switch to Screen 1" = [ ];
        "Switch to Screen 2" = [ ];
        "Switch to Screen 3" = [ ];
        "Switch to Screen 4" = [ ];
        "Switch to Screen 5" = [ ];
        "Switch to Screen 6" = [ ];
        "Switch to Screen 7" = [ ];
        "Switch to Screen Above" = [ ];
        "Switch to Screen Below" = [ ];
        "Switch to Screen to the Left" = [ ];
        "Switch to Screen to the Right" = [ ];
        "Toggle Night Color" = [ ];
        "Toggle Window Raise/Lower" = [ ];
        ToggleMouseClick = "Meta+*";
        "Walk Through Windows" = "Alt+Tab";
        "Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
        "Walk Through Windows Alternative" = [ ];
        "Walk Through Windows Alternative (Reverse)" = [ ];
        "Walk Through Windows of Current Application" = "Alt+`";
        "Walk Through Windows of Current Application (Reverse)" = "Alt+~";
        "Walk Through Windows of Current Application Alternative" = [ ];
        "Walk Through Windows of Current Application Alternative (Reverse)" = [ ];
        "Window Above Other Windows" = [ ];
        "Window Below Other Windows" = [ ];
        "Window Close" = ["Meta+W" "Alt+F4"];
        "Window Custom Quick Tile Bottom" = [ ];
        "Window Custom Quick Tile Left" = [ ];
        "Window Custom Quick Tile Right" = [ ];
        "Window Custom Quick Tile Top" = [ ];
        "Window Fullscreen" = "Ctrl+F11";
        "Window Grow Horizontal" = [ ];
        "Window Grow Vertical" = [ ];
        "Window Lower" = [ ];
        "Window Maximize" = ["F11" "Meta+PgUp"];
        "Window Maximize Horizontal" = [ ];
        "Window Maximize Vertical" = [ ];
        "Window Minimize" = ["Meta+PgDown" "Meta+N"];
        "Window Move" = [ ];
        "Window Move Center" = [ ];
        "Window No Border" = [ ];
        "Window On All Desktops" = [ ];
        "Window One Desktop Down" = "Meta+Ctrl+J";
        "Window One Desktop Up" = "Meta+Ctrl+K";
        "Window One Desktop to the Left" = "Meta+Ctrl+H";
        "Window One Desktop to the Right" = "Meta+Ctrl+L";
        "Window One Screen Down" = [ ];
        "Window One Screen Up" = [ ];
        "Window One Screen to the Left" = [ ];
        "Window One Screen to the Right" = [ ];
        "Window Operations Menu" = "Alt+F3";
        "Window Pack Down" = [ ];
        "Window Pack Left" = [ ];
        "Window Pack Right" = [ ];
        "Window Pack Up" = [ ];
        "Window Quick Tile Bottom" = "Meta+Down";
        "Window Quick Tile Bottom Left" = [ ];
        "Window Quick Tile Bottom Right" = [ ];
        "Window Quick Tile Left" = "Meta+Left";
        "Window Quick Tile Right" = "Meta+Right";
        "Window Quick Tile Top" = "Meta+Up";
        "Window Quick Tile Top Left" = [ ];
        "Window Quick Tile Top Right" = [ ];
        "Window Raise" = [ ];
        "Window Resize" = [ ];
        "Window Shade" = [ ];
        "Window Shrink Horizontal" = [ ];
        "Window Shrink Vertical" = [ ];
        "Window to Desktop 1" = [ ];
        "Window to Desktop 10" = [ ];
        "Window to Desktop 11" = [ ];
        "Window to Desktop 12" = [ ];
        "Window to Desktop 13" = [ ];
        "Window to Desktop 14" = [ ];
        "Window to Desktop 15" = [ ];
        "Window to Desktop 16" = [ ];
        "Window to Desktop 17" = [ ];
        "Window to Desktop 18" = [ ];
        "Window to Desktop 19" = [ ];
        "Window to Desktop 2" = [ ];
        "Window to Desktop 20" = [ ];
        "Window to Desktop 21" = [ ];
        "Window to Desktop 22" = [ ];
        "Window to Desktop 23" = [ ];
        "Window to Desktop 24" = [ ];
        "Window to Desktop 25" = [ ];
        "Window to Desktop 3" = [ ];
        "Window to Desktop 4" = [ ];
        "Window to Desktop 5" = [ ];
        "Window to Desktop 6" = [ ];
        "Window to Desktop 7" = [ ];
        "Window to Desktop 8" = [ ];
        "Window to Desktop 9" = [ ];
        "Window to Next Desktop" = [ ];
        "Window to Next Screen" = "Meta+Shift+Right";
        "Window to Previous Desktop" = [ ];
        "Window to Previous Screen" = "Meta+Shift+Left";
        "Window to Screen 0" = [ ];
        "Window to Screen 1" = [ ];
        "Window to Screen 2" = [ ];
        "Window to Screen 3" = [ ];
        "Window to Screen 4" = [ ];
        "Window to Screen 5" = [ ];
        "Window to Screen 6" = [ ];
        "Window to Screen 7" = [ ];
        disableInputCapture = "Meta+Shift+Esc";
        view_actual_size = "Meta+0";
        view_zoom_in = [ ];
        view_zoom_out = [ ];
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
    configFile = {
      baloofilerc.General.dbVersion = 2;
      dolphinrc = {
        DetailsMode.PreviewSize = 16;
        ExtractDialog = {
          "2226x1252 screen: Height" = 626;
          "2226x1252 screen: Width" = 1409;
          "DirHistory[$e]" = "$HOME/.local/share/,$HOME/.local/share/plasma/look-and-feel/,/";
        };
        General = {
          ShowFullPath = true;
          ShowZoomSlider = false;
          SortingChoice = "CaseSensitiveSorting";
          ViewPropsTimestamp = "2025,9,1,8,51,47.306";
        };
        "KFileDialog Settings" = {
          "Places Icons Auto-resize" = false;
          "Places Icons Static Size" = 22;
        };
        PreviewSettings.Plugins = "audiothumbnail,avif,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,jxl,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,gsf-office,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,gdk-pixbuf-thumbnailer,ffmpegthumbs";
      };
      kactivitymanagerdrc.activities."7a5c152a-e224-4d67-a50f-b6ba8dbc59ae" = "Default";
      katerc = {
        General = {
          "Days Meta Infos" = 30;
          PinnedDocuments = "";
          "Save Meta Infos" = true;
          "Show Full Path in Title" = false;
          "Show Menu Bar" = true;
          "Show Status Bar" = true;
          "Show Tab Bar" = true;
          "Show Url Nav Bar" = true;
        };
        filetree = {
          editShade = "30,78,103";
          listMode = false;
          middleClickToClose = false;
          shadingEnabled = true;
          showCloseButton = false;
          showFullPathOnRoots = false;
          showToolbar = true;
          sortRole = 0;
          viewShade = "77,46,91";
        };
      };
      kcminputrc = {
        "ButtonRebinds/Tablet/Wacom Intuos PT M 2 Pad" = {
          "2" = "Key,Ctrl+Z";
          "3" = "Key,Ctrl+Shift+Z";
        };
        "ButtonRebinds/TabletTool/Wacom Intuos PT M 2 Pen" = {
          "331" = "Key,V";
          "332" = "Key,P";
        };
        Keyboard = {
          RepeatDelay = 250;
          RepeatRate = 40;
        };
        "Libinput/1133/50503/Logitech USB Receiver" = {
          PointerAcceleration = 0.200;
          PointerAccelerationProfile = 1;
        };
        "Libinput/1386/830/Wacom Intuos PT M 2 Pen" = {
          OutputUuid = "ca6e6d04-a7e2-4b46-b354-349e2b119a9d";
          TabletToolPressureRangeMax = 1;
          TabletToolPressureRangeMin = 1;
        };
        Mouse.X11LibInputXAccelProfileFlat = true;
      };
      kded5rc.Module-device_automounter.autoload = false;
      kdeglobals = {
        General = {
          TerminalApplication = "kitty";
          TerminalService = "kitty.desktop";
          UseSystemBell = true;
          XftAntialias = true;
          XftHintStyle = "hintfull";
          XftSubPixel = "none";
          fixed = lib.mkForce "Overpass Mono,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
          font = lib.mkForce "Overpass,11,-1,5,300,0,0,0,0,0,0,0,0,0,0,1,Light";
          menuFont = "Overpass,11,-1,5,300,0,0,0,0,0,0,0,0,0,0,1,Light";
          smallestReadableFont = "Overpass,9,-1,5,300,0,0,0,0,0,0,0,0,0,0,1,Light";
          toolBarFont = "Overpass,11,-1,5,300,0,0,0,0,0,0,0,0,0,0,1,Light";
        };
        Icons.Theme = "Colloid-Dark";
        KDE = {
          AnimationDurationFactor = 0.17677669529663687;
          DndBehavior = "MoveIfSameDevice";
          DoubleClickInterval = 200;
          contrast = 4;
          frameContrast = 0.2;
        };
        "KFileDialog Settings" = {
          "Allow Expansion" = true;
          "Automatically select filename extension" = true;
          "Breadcrumb Navigation" = false;
          "Decoration position" = 2;
          "Show Full Path" = false;
          "Show Inline Previews" = true;
          "Show Preview" = false;
          "Show Speedbar" = true;
          "Show hidden files" = false;
          "Sort by" = "Date";
          "Sort directories first" = true;
          "Sort hidden files last" = false;
          "Sort reversed" = false;
          "Speedbar Width" = 140;
          "View Style" = "DetailTree";
        };
        PreviewSettings = {
          EnableRemoteFolderThumbnail = false;
          MaximumRemoteSize = 0;
        };
        Sounds.Theme = "MIUI";
        WM = {
          activeBackground = "39,39,39";
          activeBlend = "39,39,39";
          activeFont = "Overpass,11,-1,5,300,0,0,0,0,0,0,0,0,0,0,1,Light";
          activeForeground = "223,223,223";
          inactiveBackground = "30,30,30";
          inactiveBlend = "30,30,30";
          inactiveForeground = "139,139,139";
        };
      };
      kiorc = {
        Confirmations = {
          ConfirmDelete = false;
          ConfirmEmptyTrash = true;
          ConfirmTrash = false;
        };
        "Executable scripts".behaviourOnLaunch = "execute";
      };
      klaunchrc = {
        BusyCursorSettings.Bouncing = false;
        FeedbackStyle.BusyCursor = false;
      };
      krunnerrc = {
        #General = {
          #FreeFloating = true;
          #historyBehavior = "ImmediateCompletion";
        #};
        Plugins = {
          baloosearchEnabled = true;
          browserhistoryEnabled = false;
          browsertabsEnabled = false;
          krunner_dictionaryEnabled = false;
          krunner_keysEnabled = true;
          krunner_killEnabled = false;
          krunner_konsoleprofilesEnabled = false;
          krunner_kwinEnabled = true;
          krunner_recentdocumentsEnabled = false;
          krunner_sessionsEnabled = false;
          krunner_shellEnabled = false;
          krunner_spellcheckEnabled = false;
          krunner_webshortcutsEnabled = false;
          "org.kde.activities2Enabled" = false;
          windowsEnabled = false;
        };
        "Plugins/Favorites".plugins = "krunner_sessions,krunner_powerdevil,krunner_services,krunner_systemsettings";
      };
      #kscreenlockerrc = {
      #  Daemon = {
      #    LockGrace = 900;
      #    Timeout = 30;
      #  };
      #  Greeter.WallpaperPlugin = lib.mkForce "a2n.blur";
      #  "Greeter/LnF/General".showMediaControls = false;
      #  "Greeter/Wallpaper/a2n.blur/General" = {
      #    Image = "/home/oisin/Pictures/Wallpapers/macos-space-1.jpg";
      #    PreviewImage = "/home/oisin/Pictures/Wallpapers/macos-space-1.jpg";
      #    SlidePaths = "/home/oisin/.local/share/wallpapers/,/usr/share/wallpapers/";
      #  };
      #  "Greeter/Wallpaper/org.kde.image/General" = {
      #    Image = lib.mkForce "/usr/share/wallpapers/PastelHills/";
      #    PreviewImage = "/usr/share/wallpapers/PastelHills/";
      #    SlidePaths = "/home/oisin/.local/share/wallpapers/,/usr/share/wallpapers/";
      #  };
      #};
      ksplashrc.KSplash = {
        Engine = "none";
        Theme = "None";
      };
      kwalletrc.Wallet."First Use" = false;
      kwinrc = {
        Desktops = {
          Id_1 = "603ac86d-a706-4ef0-bb79-311b58262c86";
          Id_2 = "5894213d-9609-4644-a863-aa02cbf44cc3";
          Id_3 = "8b8d50cd-f89b-4f02-96ab-f91e78df7bf2";
          Number = 3;
          Rows = 2;
        };
        EdgeBarrier = {
          CornerBarrier = false;
          EdgeBarrier = 50;
        };
        Effect-overview.BorderActivate = 9;
        Effect-translucency = {
          ComboboxPopups = 50;
          Dialogs = 48;
          Menus = 35;
          MoveResize = 94;
        };
        Effect-wobblywindows = {
          AdvancedMode = true;
          Drag = 69;
          MoveFactor = 9;
          Stiffness = 41;
          WobblynessLevel = 2;
        };
        MouseBindings.CommandTitlebarWheel = "Raise/Lower";
        NightColor = {
          Active = true;
          NightTemperature = 4200;
        };
        Plugins = {
          cubeEnabled = true;
          dimscreenEnabled = true;
          kinetic_maximizeEnabled = false;
          krohnkiteEnabled = false;
          kwin4_effect_shapecornersEnabled = false;
          kzonesEnabled = true;
          macsimize6Enabled = false;
          shakecursorEnabled = false;
          sheetEnabled = true;
          truely-maximizedEnabled = false;
          virtualdesktopsonlyonprimaryEnabled = false;
        };
        Script-krohnkite = {
          floatSkipPagerWindows = true;
          monocleMaximize = false;
          noTileBorder = true;
          screenGapBetween = 10;
          screenGapBottom = 20;
          screenGapLeft = 50;
          screenGapRight = 50;
          screenGapTop = 50;
        };
        Script-kzones = {
          enableZoneOverlay = true;
          layoutsJson = "[\n    {\n        \"name\": \"Vertical Monitor Tiles\",\n        \"padding\": 0,\n        \"zones\": [\n            {                 \n                \"x\": 0,\n                \"y\": 0,\n                \"height\": 16,\n                \"width\": 100\n            },\n            {\n                \"x\": 0,\n                \"y\": 16,\n                \"height\": 50,\n                \"width\": 100\n            },\n            {\n                \"x\": 0,\n                \"y\": 66,\n                \"height\": 34,\n                \"width\": 100\n            }\n        ]\n    }\n]";
          trackLayoutPerScreen = true;
          zoneSelectorTriggerDistance = 0;
        };
        TabBox = {
          DesktopMode = 0;
          HighlightWindows = false;
          LayoutName = "AquaMediumIcons";
        };
        TabBoxAlternative.LayoutName = "coverswitch";
        "Tiling/2078e148-2def-4401-80b4-74e59c270d7c/a69b37ee-fb56-45ab-bbed-99a5469f070f".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "Tiling/36929564-0fe4-4901-b984-30647e83777f/a69b37ee-fb56-45ab-bbed-99a5469f070f".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "Tiling/47911e90-6a37-59ed-9aa2-6aba0f44e8f5" = {
          "[Tiling][5894213d-9609-4644-a863-aa02cbf44cc3][]" = "";
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/5894213d-9609-4644-a863-aa02cbf44cc3/46a68147-1ba2-4e54-bce2-ccdde71a8834" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/5894213d-9609-4644-a863-aa02cbf44cc3/632b779d-d4a2-48aa-87fc-01b4e11ff4d7" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/5894213d-9609-4644-a863-aa02cbf44cc3/a69b37ee-fb56-45ab-bbed-99a5469f070f" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/5894213d-9609-4644-a863-aa02cbf44cc3/ae03df65-0d5c-4a21-9ea8-592c5b3a1ad4".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "Tiling/5894213d-9609-4644-a863-aa02cbf44cc3/ca6e6d04-a7e2-4b46-b354-349e2b119a9d" = {
          "[Tiling][603ac86d-a706-4ef0-bb79-311b58262c86][]" = "";
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/603ac86d-a706-4ef0-bb79-311b58262c86/46a68147-1ba2-4e54-bce2-ccdde71a8834" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/603ac86d-a706-4ef0-bb79-311b58262c86/632b779d-d4a2-48aa-87fc-01b4e11ff4d7" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/603ac86d-a706-4ef0-bb79-311b58262c86/a69b37ee-fb56-45ab-bbed-99a5469f070f" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/603ac86d-a706-4ef0-bb79-311b58262c86/ae03df65-0d5c-4a21-9ea8-592c5b3a1ad4".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "Tiling/603ac86d-a706-4ef0-bb79-311b58262c86/ca6e6d04-a7e2-4b46-b354-349e2b119a9d" = {
          "[Tiling][64f9d89e-e80f-4350-a9bf-1ceb57f7e5f5][]" = "";
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/64f9d89e-e80f-4350-a9bf-1ceb57f7e5f5/a69b37ee-fb56-45ab-bbed-99a5469f070f".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "Tiling/64f9d89e-e80f-4350-a9bf-1ceb57f7e5f5/ae03df65-0d5c-4a21-9ea8-592c5b3a1ad4".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "Tiling/64f9d89e-e80f-4350-a9bf-1ceb57f7e5f5/ca6e6d04-a7e2-4b46-b354-349e2b119a9d".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "Tiling/7b4a279c-a947-4161-aa79-1f4d9e480e28/a69b37ee-fb56-45ab-bbed-99a5469f070f".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "Tiling/8b8d50cd-f89b-4f02-96ab-f91e78df7bf2/46a68147-1ba2-4e54-bce2-ccdde71a8834" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/8b8d50cd-f89b-4f02-96ab-f91e78df7bf2/632b779d-d4a2-48aa-87fc-01b4e11ff4d7" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/8b8d50cd-f89b-4f02-96ab-f91e78df7bf2/a69b37ee-fb56-45ab-bbed-99a5469f070f" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/8b8d50cd-f89b-4f02-96ab-f91e78df7bf2/ca6e6d04-a7e2-4b46-b354-349e2b119a9d" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/a5a9447a-9cf9-548f-9d0f-13294d772cc1" = {
          "[Tiling][b3552a90-8104-4f0e-9ef9-7cc9834d8d60][]" = "";
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/b3552a90-8104-4f0e-9ef9-7cc9834d8d60/a69b37ee-fb56-45ab-bbed-99a5469f070f" = {
          "[Tiling][c1a303cf-7c8a-40ae-87a7-d8023fff69b0][]" = "";
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/c1a303cf-7c8a-40ae-87a7-d8023fff69b0/a69b37ee-fb56-45ab-bbed-99a5469f070f".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "Tiling/c1a303cf-7c8a-40ae-87a7-d8023fff69b0/ae03df65-0d5c-4a21-9ea8-592c5b3a1ad4".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "Tiling/c1a303cf-7c8a-40ae-87a7-d8023fff69b0/ca6e6d04-a7e2-4b46-b354-349e2b119a9d".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        Wayland.EnablePrimarySelection = false;
        Windows = {
          Placement = "Random";
          SnapOnlyWhenOverlapping = true;
          WindowSnapZone = 5;
        };
        Windows_HDR = {
          MaxFrameAverage = 0;
          MaxLuminance = 420;
          Reference = 420;
        };
        Xwayland.Scale = 1;
        "org.kde.kdecoration2" = {
          ButtonsOnLeft = "N";
          ButtonsOnRight = "_IFAX";
          ShowToolTips = false;
          library = "org.kde.kwin.aurorae.v2";
          theme = "__aurorae__svg__WillowDarkAlt";
        };
      };
      kwinrulesrc = {
        "185b332a-3d68-4c49-a5a8-ea523d68b990" = {
          size = "300,600";
          sizerule = 2;
          types = 257;
        };
        "3dfa7bd7-84b3-412e-bf86-3ee261db875b" = {
          Description = "Steam";
          positionrule = 2;
          sizerule = 2;
          title = "Friends List";
          titlematch = 2;
          types = 1;
          wmclasscomplete = true;
          wmclassmatch = 1;
        };
        "96bb6aa5-3b14-4aa4-8026-5b3466e9beda" = {
          Description = "[Global] Window Size";
          Enabled = false;
          size = "1500,1000";
          sizerule = 3;
          types = 1;
        };
        General = {
          count = 5;
          rules = "e55ab18e-2927-408a-8324-9a455d318da6,df52d4ed-dec3-481f-ac14-77e10286b528,ba48fbd1-66a2-4e68-a12b-4b1d25675c0e,ba666adb-d86d-49f4-89f5-85df22ca07fb,96bb6aa5-3b14-4aa4-8026-5b3466e9beda";
        };
        aec4fd88-7f7f-41a8-b8cd-cf3ecd629207 = {
          size = "1310,860";
          sizerule = 3;
        };
        ba48fbd1-66a2-4e68-a12b-4b1d25675c0e = {
          Description = "Steam Friends";
          size = "300,600";
          sizerule = 2;
          title = "Friends List";
          titlematch = 1;
          wmclass = "steamwebhelper steam";
          wmclasscomplete = true;
          wmclassmatch = 1;
        };
        ba666adb-d86d-49f4-89f5-85df22ca07fb = {
          Description = "[Terminal]";
          position = "12,497";
          positionrule = 1;
          wmclass = "kitty";
          wmclassmatch = 1;
        };
        df52d4ed-dec3-481f-ac14-77e10286b528 = {
          Description = "Window settings for kitty";
          position = "11,1233";
          positionrule = 2;
          title = "btop";
          titlematch = 1;
          types = 1;
          wmclass = "kitty";
          wmclassmatch = 1;
        };
        e55ab18e-2927-408a-8324-9a455d318da6 = {
          Description = "Window settings for com.rtosta.zapzap";
          size = "1400,860";
          sizerule = 3;
          title = "ZapZap";
          types = 1;
          wmclass = "\scom.rtosta.zapzap";
          wmclasscomplete = true;
          wmclassmatch = 1;
        };
        edf6c59a-e3b9-443b-860f-3606751f024d.sizerule = 3;
      };
      plasma-localerc.Formats.LANG = "en_IE.UTF-8";
      plasmanotifyrc = {
        "Applications/app.zen_browser.zen".Seen = true;
        "Applications/com.rtosta.zapzap".Seen = true;
        "Applications/dev.vencord.Vesktop".Seen = true;
        "Applications/io.github.ungoogled_software.ungoogled_chromium".Seen = true;
        "Applications/kando".Seen = true;
        "Applications/org.gnome.DejaDup".Seen = true;
        "Applications/org.qbittorrent.qBittorrent".Seen = true;
        "Applications/org.wezfurlong.wezterm".Seen = true;
        "Services/kdeconnect".ShowPopups = false;
      };
      plasmaparc.General.RaiseMaximumVolume = true;
      plasmarc = {
        PlasmaToolTips.Delay = "-1";
        Theme.name = "Obsidian-Edge";
        Wallpapers.usersWallpapers = "/home/oisin/Pictures/Earth_Wallpaper.jpg,/home/oisin/Pictures/Wallpapers/Earth_Wallpaper_2.jpg,/home/oisin/Pictures/Wallpapers/macos-space-1.jpg";
      };
      spectaclerc = {
        ImageSave = {
          lastImageSaveAsLocation = "file:///home/oisin/Pictures/DIGI/Boolean Algebra.png";
          lastImageSaveLocation = "file:///home/oisin/Pictures/DIGI/Boolean Algebra.png";
          translatedScreenshotsFolder = "Screenshots";
        };
        VideoSave.translatedScreencastsFolder = "Screencasts";
      };
    };

    dataFile = {
      "kate/anonymous.katesession" = {
        "Document 0".URL = "file:///media/ssd-aon/SteamLibrary/steamapps/common/Subnautica2/Subnautica2/Content/VideoTours/shallows.json";
        "Kate Plugins" = {
          bookmarksplugin = false;
          cmaketoolsplugin = false;
          compilerexplorer = false;
          eslintplugin = false;
          externaltoolsplugin = true;
          formatplugin = false;
          katebacktracebrowserplugin = false;
          katebuildplugin = false;
          katecloseexceptplugin = false;
          katecolorpickerplugin = false;
          katectagsplugin = false;
          katefilebrowserplugin = false;
          katefiletreeplugin = true;
          kategdbplugin = false;
          kategitblameplugin = false;
          katekonsoleplugin = true;
          kateprojectplugin = true;
          katereplicodeplugin = false;
          katesearchplugin = true;
          katesnippetsplugin = false;
          katesqlplugin = false;
          katesymbolviewerplugin = false;
          katexmlcheckplugin = false;
          katexmltoolsplugin = false;
          keyboardmacrosplugin = false;
          ktexteditorpreviewplugin = false;
          latexcompletionplugin = false;
          lspclientplugin = true;
          openlinkplugin = false;
          rainbowparens = false;
          rbqlplugin = false;
          tabswitcherplugin = true;
          templateplugin = false;
          textfilterplugin = true;
        };
        MainWindow0 = {
          "Active ViewSpace" = 0;
          Kate-MDI-H-Splitter = "0,1352,0";
          Kate-MDI-Sidebar-0-Bar-0-TvList = "kate_private_plugin_katefiletreeplugin,kateproject,kateprojectgit,lspclient_symbol_outline";
          Kate-MDI-Sidebar-0-LastSize = 200;
          Kate-MDI-Sidebar-0-SectSizes = 0;
          Kate-MDI-Sidebar-0-Splitter = 932;
          Kate-MDI-Sidebar-1-Bar-0-TvList = "";
          Kate-MDI-Sidebar-1-LastSize = 200;
          Kate-MDI-Sidebar-1-SectSizes = 0;
          Kate-MDI-Sidebar-1-Splitter = 932;
          Kate-MDI-Sidebar-2-Bar-0-TvList = "";
          Kate-MDI-Sidebar-2-LastSize = 200;
          Kate-MDI-Sidebar-2-SectSizes = 0;
          Kate-MDI-Sidebar-2-Splitter = 1352;
          Kate-MDI-Sidebar-3-Bar-0-TvList = "output,diagnostics,kate_plugin_katesearch,kateprojectinfo,kate_private_plugin_katekonsoleplugin";
          Kate-MDI-Sidebar-3-LastSize = 200;
          Kate-MDI-Sidebar-3-SectSizes = 0;
          Kate-MDI-Sidebar-3-Splitter = 1118;
          Kate-MDI-Sidebar-Style = 2;
          Kate-MDI-Sidebar-Visible = true;
          Kate-MDI-ToolView-diagnostics-Position = 3;
          Kate-MDI-ToolView-diagnostics-Show-Button-In-Sidebar = true;
          Kate-MDI-ToolView-diagnostics-Visible = false;
          Kate-MDI-ToolView-kate_plugin_katesearch-Position = 3;
          Kate-MDI-ToolView-kate_plugin_katesearch-Show-Button-In-Sidebar = true;
          Kate-MDI-ToolView-kate_plugin_katesearch-Visible = false;
          Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Position = 0;
          Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Show-Button-In-Sidebar = true;
          Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Visible = false;
          Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Position = 3;
          Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Show-Button-In-Sidebar = true;
          Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Visible = false;
          Kate-MDI-ToolView-kateproject-Position = 0;
          Kate-MDI-ToolView-kateproject-Show-Button-In-Sidebar = true;
          Kate-MDI-ToolView-kateproject-Visible = false;
          Kate-MDI-ToolView-kateprojectgit-Position = 0;
          Kate-MDI-ToolView-kateprojectgit-Show-Button-In-Sidebar = true;
          Kate-MDI-ToolView-kateprojectgit-Visible = false;
          Kate-MDI-ToolView-kateprojectinfo-Position = 3;
          Kate-MDI-ToolView-kateprojectinfo-Show-Button-In-Sidebar = true;
          Kate-MDI-ToolView-kateprojectinfo-Visible = false;
          Kate-MDI-ToolView-lspclient_symbol_outline-Position = 0;
          Kate-MDI-ToolView-lspclient_symbol_outline-Show-Button-In-Sidebar = true;
          Kate-MDI-ToolView-lspclient_symbol_outline-Visible = false;
          Kate-MDI-ToolView-output-Position = 3;
          Kate-MDI-ToolView-output-Show-Button-In-Sidebar = true;
          Kate-MDI-ToolView-output-Visible = false;
          Kate-MDI-V-Splitter = "0,932,0";
        };
        "MainWindow0 Settings".WindowState = 8;
        "MainWindow0-Splitter 0" = {
          Children = "MainWindow0-ViewSpace 0";
          Orientation = 1;
          Sizes = 1352;
        };
        "MainWindow0-ViewSpace 0" = {
          "Active View" = 0;
          Count = 1;
          Documents = 0;
          "View 0" = 0;
        };
        "MainWindow0-ViewSpace 0 0".ScrollLine = 46776;
        "Open Documents".Count = 1;
        "Open MainWindows".Count = 1;
        "Plugin:kateprojectplugin:".projects = "";
        "Plugin:katesearchplugin:MainWindow:0" = {
          BinaryFiles = false;
          CurrentExcludeFilter = "-1";
          CurrentFilter = "-1";
          ExcludeFilters = "";
          ExpandSearchResults = false;
          Filters = "";
          FollowSymLink = false;
          HiddenFiles = false;
          MatchCase = false;
          Place = 1;
          Recursive = true;
          Replaces = "";
          Search = "";
          SearchAsYouTypeAllProjects = true;
          SearchAsYouTypeCurrentFile = true;
          SearchAsYouTypeFolder = true;
          SearchAsYouTypeOpenFiles = true;
          SearchAsYouTypeProject = true;
          SearchDiskFiles = "";
          SearchDiskFiless = "";
          SizeLimit = 128;
          UseRegExp = false;
        };
      };
    };
  };
}
