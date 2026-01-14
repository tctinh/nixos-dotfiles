{ lib, ... }: {
  #############################################################################
  # Plasma/KDE Configuration (via plasma-manager)
  #############################################################################
  programs.plasma = {
    enable = true;

    # Workspace settings
    workspace = {
      clickItemTo = "select";
      lookAndFeel = "Nordic";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
      };
      iconTheme = "Papirus-Dark";
      colorScheme = "CatppuccinMacchiato";
    };

    # Fonts
    fonts = {
      general = {
        family = "Noto Sans";
        pointSize = 10;
      };
      fixedWidth = {
        family = "FantasqueSansM Nerd Font";
        pointSize = 11;
      };
    };

    # Panel configuration
    panels = [
      {
        location = "bottom";
        height = 44;
        floating = true;
        widgets = [
          {
            kickoff = {
              sortAlphabetically = true;
              icon = "nix-snowflake-white";
            };
          }
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:microsoft-edge.desktop"
                "applications:code.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.battery"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
              ];
            };
          }
          {
            digitalClock = {
              calendar.firstDayOfWeek = "monday";
              time.format = "24h";
            };
          }
        ];
      }
    ];

    # Window Manager (KWin) configuration
    kwin = {
      virtualDesktops = {
        rows = 1;
        number = 3;
      };
      titlebarButtons = {
        left = [ "on-all-desktops" "keep-above-windows" ];
        right = [ "minimize" "maximize" "close" ];
      };
      effects = {
        desktopSwitching.animation = "slide";
        shakeCursor.enable = true;
      };
    };

    # Keyboard shortcuts
    shortcuts = {
      kwin = {
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch Window Down" = "Meta+Alt+Down";
        "Switch Window Up" = "Meta+Alt+Up";
        "Switch Window Left" = "Meta+Alt+Left";
        "Switch Window Right" = "Meta+Alt+Right";
        "Overview" = "Meta+W";
        "Grid View" = "Meta+G";
        "Show Desktop" = "Meta+D";
      };
      ksmserver = {
        "Lock Session" = [ "Meta+L" "Screensaver" ];
      };
    };

    # Hotkeys (custom commands)
    hotkeys.commands = {
      "launch-konsole" = {
        name = "Launch Konsole";
        key = "Meta+Return";
        command = "konsole";
      };
      "launch-dolphin" = {
        name = "Launch Dolphin";
        key = "Meta+E";
        command = "dolphin";
      };
    };

    # KRunner configuration
    krunner = {
      position = "center";
      activateWhenTypingOnDesktop = true;
      historyBehavior = "enableSuggestions";
    };

    # Screen locker
    kscreenlocker = {
      autoLock = true;
      lockOnResume = true;
      timeout = 10;
    };

    # Input devices
    input = {
      keyboard = {
        numlockOnStartup = "on";
      };
    };

    # Power management
    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = true;
        dimDisplay.idleTimeout = 300;
      };
      battery = {
        autoSuspend.action = "sleep";
        autoSuspend.idleTimeout = 600;
        dimDisplay.enable = true;
        dimDisplay.idleTimeout = 120;
      };
    };

    # Low-level config file overrides
    configFile = {
      kwinrc = {
        Tiling.padding = 4;
        Windows = {
          RollOverDesktops = true;
          ElectricBorderMaximize = false;
          ElectricBorderTiling = false;
          AutoRaise = true;
          ClickRaise = true;
        };
        Plugins = {
          slideEnabled = lib.mkForce false;
          fadedesktopEnabled = false;
          kzonesEnabled = true;
          rememberwindowpositionsEnabled = true;
          shakecursorEnabled = true;
          synchronizeskipswitcherEnabled = false;
        };
        "Effect-overview".BorderActivate = 9;
        "Effect-translucency".MoveResize = 93;
        TabBox.LayoutName = "thumbnail_grid";
        "Script-desktopchangeosd".PopupHideDelay = 200;
        "Script-rememberwindowpositions" = {
          moveActivity = true;
          moveVirtualDesktop = true;
          restoreResizedQuickTile = true;
        };
        "org.kde.kdecoration2" = {
          BorderSize = "Tiny";
          BorderSizeAuto = false;
          ButtonsOnLeft = "SF";
          ButtonsOnRight = "IAX";
          library = "org.kde.breeze";
          theme = "Breeze";
        };
      };
      baloofilerc."Basic Settings"."Indexing-Enabled" = true;
    };
  };
}
