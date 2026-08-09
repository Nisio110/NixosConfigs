# Remaining $XDG_CONFIG_HOME rc files. kwinrc/kwinrulesrc live in ./kwin.nix.
{ lib, ... }:
{
  programs.plasma.configFile = {
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
}
