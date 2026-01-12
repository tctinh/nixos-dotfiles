{ config, pkgs, lib, ... }:

let
  oh-my-bash-src = pkgs.fetchFromGitHub {
    owner = "ohmybash";
    repo = "oh-my-bash";
    rev = "b88b2244f15a0e0f65f1588a3de2db6d1c55169b";
    sha256 = "sha256-yl2ZK+lCHfTwB2mRfZT7egFWUa40p3Z0O4SdqiOpGR8=";
  };
in
{
  home.username = "tctinh";
  home.homeDirectory = "/home/tctinh";
  home.stateVersion = "25.11";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #############################################################################
  # Packages
  #############################################################################
  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.fantasque-sans-mono

    # NVIDIA PRIME helper script
    (writeShellScriptBin "prime-run" ''
      #!/bin/sh
      __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only "$@"
    '')

    # KDE Theming
    kdePackages.qtstyleplugin-kvantum
    catppuccin-kvantum
    catppuccin-kde        # Catppuccin color scheme for KDE
    catppuccin-cursors
    papirus-icon-theme
    bibata-cursors
    nordic                # Nordic theme
  ];

  #############################################################################
  # Wallpapers
  #############################################################################
  home.file.".local/share/wallpapers/Nordic-mountain-wallpaper.jpg".source = ../dotfiles/wallpapers/Nordic-mountain-wallpaper.jpg;
  home.file.".local/share/wallpapers/nordic-wallpaper.jpg".source = ../dotfiles/wallpapers/nordic-wallpaper.jpg;

  #############################################################################
  # Programs
  #############################################################################
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "tctinh";
    userEmail = "your-email@example.com";  # TODO: Update this
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      la = "ls -A";
      l = "ls -CF";
      update = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
      hm-switch = "home-manager switch --flake ~/nixos-dotfiles";
      # Quick navigation
      dots = "cd ~/nixos-dotfiles";
    };
    initExtra = ''
      export OSH=${oh-my-bash-src}
      source "$OSH/oh-my-bash.sh"
    '';
  };

  #############################################################################
  # Plasma/KDE Configuration (via plasma-manager)
  #############################################################################
  programs.plasma = {
    enable = true;

    # Workspace settings
    workspace = {
      clickItemTo = "select";  # Single click to select, double-click to open
      lookAndFeel = "Nordic";  # Nordic theme
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
      };
      iconTheme = "Papirus-Dark";
      colorScheme = "CatppuccinMacchiato";  # Catppuccin Macchiato color scheme
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

    # Desktop settings
    desktop = {
      # Empty for now - add widgets here if needed
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
      # Virtual desktops
      virtualDesktops = {
        rows = 1;
        number = 3;
      };
      # Titlebar buttons
      titlebarButtons = {
        left = [ "on-all-desktops" "keep-above-windows" ];
        right = [ "minimize" "maximize" "close" ];
      };
      # Effects
      effects = {
        desktopSwitching.animation = "slide";
        shakeCursor.enable = true;
      };
    };

    # Keyboard shortcuts
    shortcuts = {
      kwin = {
        # Desktop switching with Meta+1/2/3
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        # Window navigation
        "Switch Window Down" = "Meta+Alt+Down";
        "Switch Window Up" = "Meta+Alt+Up";
        "Switch Window Left" = "Meta+Alt+Left";
        "Switch Window Right" = "Meta+Alt+Right";
        # Overview
        "Overview" = "Meta+W";
        "Grid View" = "Meta+G";
        # Show desktop
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
      timeout = 10;  # Lock after 10 minutes of inactivity
    };

    # Konsole configuration
    konsole = {
      defaultProfile = "NixOS";
      profiles = {
        NixOS = {
          colorScheme = "Breeze";
          font = {
            name = "FantasqueSansM Nerd Font";
            size = 12;
          };
          command = "${pkgs.bash}/bin/bash";
        };
      };
    };

    # Input devices
    input = {
      keyboard = {
        numlockOnStartup = "on";
      };
      touchpad = {
        naturalScroll = true;
        tapToClick = true;
        twoFingerTap = "rightClick";
      };
    };

    # Power management
    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = true;
        dimDisplay.idleTimeout = 300;  # 5 minutes
      };
      battery = {
        autoSuspend.action = "sleep";
        autoSuspend.idleTimeout = 600;  # 10 minutes
        dimDisplay.enable = true;
        dimDisplay.idleTimeout = 120;  # 2 minutes
      };
    };

    # Low-level config file overrides (for anything not covered by plasma-manager modules)
    configFile = {
      # KWin tiling configuration
      kwinrc = {
        Tiling.padding = 4;
        Windows = {
          RollOverDesktops = true;
          ElectricBorderMaximize = false;
          ElectricBorderTiling = false;
        };
        Plugins = {
          slideEnabled = false;
          kzonesEnabled = true;
          rememberwindowpositionsEnabled = true;
        };
        "Effect-overview".BorderActivate = 9;  # Overview on screen edge (9 = no edge)
        "org.kde.kdecoration2" = {
          BorderSize = "Tiny";
          BorderSizeAuto = false;
          library = "org.kde.breeze";
          theme = "Breeze";
        };
      };

      # Baloo file indexer
      baloofilerc."Basic Settings"."Indexing-Enabled" = true;
    };
  };

  #############################################################################
  # XDG Configuration Files (for non-plasma-manager managed configs)
  #############################################################################

  # Fish shell config (if you use fish)
  xdg.configFile."fish/config.fish" = {
    text = ''
      # Fish shell configuration
      set -gx EDITOR vim
      
      # Aliases
      alias ll 'ls -la'
      alias update 'sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos'
    '';
  };

  #############################################################################
  # Session Variables
  #############################################################################
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "code";
  };
}
