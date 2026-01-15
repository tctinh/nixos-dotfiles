{ lib, ... }: {
  #############################################################################
  # Plasma/KDE Configuration - Synced from local KDE settings
  #############################################################################
  programs.plasma = {
    enable = true;

    #=========================================================================
    # Workspace Settings
    #=========================================================================
    workspace = {
      lookAndFeel = "Nordic-bluish";
      colorScheme = "UtterlyNord";
      iconTheme = "Tela-circle-nord-dark";
      wallpaper = null; # Set manually or via files.nix
    };

    #=========================================================================
    # Fonts
    #=========================================================================
    fonts = {
      general = {
        family = "Inter";
        pointSize = 10;
      };
      fixedWidth = {
        family = "JetBrainsMono Nerd Font";
        pointSize = 10;
      };
      small = {
        family = "Inter";
        pointSize = 8;
      };
      toolbar = {
        family = "Inter";
        pointSize = 10;
      };
      menu = {
        family = "Inter";
        pointSize = 10;
      };
      windowTitle = {
        family = "Inter";
        pointSize = 10;
      };
    };

    #=========================================================================
    # KWin Settings
    #=========================================================================
    kwin = {
      virtualDesktops = {
        number = 3;
        rows = 1;
        names = [ "Desktop 1" "Desktop 2" "Desktop 3" ];
      };
      borderlessMaximizedWindows = false;
      titlebarButtons = {
        left = [ "on-all-desktops" ];
        right = [ "minimize" "maximize" "close" ];
      };
    };

    #=========================================================================
    # Keyboard Shortcuts
    #=========================================================================
    shortcuts = {
      # KWin shortcuts
      kwin = {
        # Desktop switching
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";

        # Desktop navigation
        "Switch One Desktop Down" = "Meta+Ctrl+Down";
        "Switch One Desktop Up" = "Meta+Ctrl+Up";
        "Switch One Desktop to the Left" = "Meta+Ctrl+Left";
        "Switch One Desktop to the Right" = "Meta+Ctrl+Right";

        # Overview & Desktop
        "Overview" = "Meta+W";
        "Show Desktop" = "Meta+D";
        "Grid View" = "Meta+G";

        # Window management
        "Window Close" = [ "Meta+C" "Alt+F4" ];
        "Window Maximize" = "Meta+F";
        "Window Minimize" = "Meta+PgDown";

        # Quick tile
        "Window Quick Tile Left" = "Meta+Left";
        "Window Quick Tile Right" = "Meta+Right";
        "Window Quick Tile Top" = "Meta+Up";
        "Window Quick Tile Bottom" = "Meta+Down";

        # Window switching
        "Walk Through Windows" = [ "Meta+Tab" "Alt+Tab" ];
        "Walk Through Windows (Reverse)" = [ "Meta+Shift+Tab" "Alt+Shift+Tab" ];
        "Walk Through Windows of Current Application" = [ "Meta+`" "Alt+`" ];
        "Walk Through Windows of Current Application (Reverse)" = [ "Meta+~" "Alt+~" ];

        # Switch window focus
        "Switch Window Down" = "Meta+Alt+Down";
        "Switch Window Up" = "Meta+Alt+Up";
        "Switch Window Left" = "Meta+Alt+Left";
        "Switch Window Right" = "Meta+Alt+Right";

        # Move window to desktop
        "Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
        "Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
        "Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
        "Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 2" = "Meta+@";
        "Window to Desktop 3" = "Meta+#";
        "Window to Desktop 4" = "Meta+$";

        # Move window between screens
        "Window to Next Screen" = "Meta+Shift+Right";
        "Window to Previous Screen" = "Meta+Shift+Left";

        # Zoom
        "view_actual_size" = "Meta+0";
        "view_zoom_in" = [ "Meta++" "Meta+=" ];
        "view_zoom_out" = "Meta+-";

        # KZones shortcuts
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
        "KZones: Snap active window" = "Meta+Shift+Space";
        "KZones: Snap all windows" = "Meta+Space";
        "KZones: Switch to next window in current zone" = "Ctrl+Alt+Up";
        "KZones: Switch to previous window in current zone" = "Ctrl+Alt+Down";
        "KZones: Toggle zone overlay" = "Ctrl+Alt+C";

        # Misc
        "Kill Window" = "Meta+Ctrl+Esc";
        "Activate Window Demanding Attention" = "Meta+Ctrl+A";
        "Expose" = "Ctrl+F9";
        "ExposeAll" = [ "Ctrl+F10" "Launch (C)" ];
        "ExposeClass" = "Ctrl+F7";
      };

      # Session management
      ksmserver = {
        "Lock Session" = [ "Meta+L" "Screensaver" ];
        "Log Out" = "Ctrl+Alt+Del";
      };

      # Plasmashell
      plasmashell = {
        "activate application launcher" = [ "Meta" "Alt+F1" ];
        "manage activities" = "Meta+Q";
        "next activity" = "Meta+A";
        "previous activity" = "Meta+Shift+A";
        "show-on-mouse-pos" = "Meta+V";
        "clipboard_action" = "Meta+Ctrl+X";
        "show dashboard" = "Ctrl+F12";
        "cycle-panels" = "Meta+Alt+P";
      };

      # Media controls
      kmix = {
        "decrease_volume" = "Volume Down";
        "increase_volume" = "Volume Up";
        "mute" = "Volume Mute";
        "mic_mute" = [ "Microphone Mute" "Meta+Volume Mute" ];
      };

      # Power management
      "org_kde_powerdevil" = {
        "powerProfile" = [ "Battery" "Meta+B" ];
      };
    };

    #=========================================================================
    # Custom Hotkeys (App Launchers)
    #=========================================================================
    hotkeys.commands = {
      "launch-terminal" = {
        name = "Launch Terminal";
        key = "Meta+T";
        command = "ghostty";
      };
      "launch-dolphin" = {
        name = "Launch Dolphin";
        key = "Meta+E";
        command = "dolphin";
      };
    };

    #=========================================================================
    # Config Files (for settings not covered by plasma-manager options)
    #=========================================================================
    configFile = {
      # KWin settings
      kwinrc = {
        Desktops = {
          Id_1 = "Desktop_1";
          Id_2 = "Desktop_2";
          Id_3 = "Desktop_3";
          Number = 3;
          Rows = 1;
        };

        Plugins = {
          fadedesktopEnabled = false;
          kzonesEnabled = true;
          rememberwindowpositionsEnabled = true;
          shakecursorEnabled = true;
          slideEnabled = false;
          krohnkiteEnabled = false;
        };

        "Effect-overview" = {
          BorderActivate = 9;
        };

        "Effect-translucency" = {
          MoveResize = 93;
        };

        "Script-kzones" = {
          layoutsJson = ''[
    {
        "name": "Priority Grid",
        "padding": 0,
        "zones": [
            { "x": 0, "y": 0, "height": 100, "width": 50 },
            { "x": 50, "y": 0, "height": 100, "width": 50 }
        ]
    },
    {
        "name": "Priority Grid",
        "padding": 0,
        "zones": [
            { "x": 0, "y": 0, "height": 100, "width": 25 },
            { "x": 25, "y": 0, "height": 100, "width": 50 },
            { "x": 75, "y": 0, "height": 100, "width": 25 }
        ]
    },
    {
        "name": "DWM",
        "zones": [
            { "x": 0, "y": 0, "height": 100, "width": 75 },
            { "x": 75, "y": 50, "height": 50, "width": 25 },
            { "x": 75, "y": 0, "height": 50, "width": 25 }
        ]
    },
    {
        "name": "Full",
        "zones": [
            { "x": 0, "y": 0, "height": 100, "width": 100 }
        ]
    }
]'';
          showOsdMessages = false;
          trackLayoutPerScreen = true;
          zoneOverlayIndicatorDisplay = 1;
          zoneSelectorTriggerDistance = 2;
        };

        "Script-rememberwindowpositions" = {
          moveActivity = true;
          moveVirtualDesktop = true;
          restoreResizedQuickTile = true;
        };

        TabBox = {
          LayoutName = "thumbnail_grid";
        };

        Tiling = {
          padding = 4;
        };

        Windows = {
          AutoRaise = true;
          ClickRaise = true;
          ElectricBorderMaximize = false;
          ElectricBorderTiling = false;
          RollOverDesktops = true;
        };
      };

      # KDE globals
      kdeglobals = {
        General = {
          ColorScheme = "UtterlyNord";
        };

        Icons = {
          Theme = "Tela-circle-nord-dark";
        };

        KDE = {
          LookAndFeelPackage = "Nordic-bluish";
          widgetStyle = "Breeze";
        };
      };
    };
  };

  #############################################################################
  # Konsole Settings (outside programs.plasma)
  #############################################################################
  programs.konsole = {
    enable = true;
    defaultProfile = "zsh";
    profiles.zsh = {
      name = "zsh";
      command = "zsh";
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 11;
      };
      colorScheme = "Breeze";
    };
  };
}
