{ config, pkgs, lib, ... }: {
  # Sway window manager via home-manager
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    
    # For NVIDIA
    extraOptions = [ "--unsupported-gpu" ];
    
    config = {
      modifier = "Mod4";
      terminal = "konsole";
      menu = "${pkgs.rofi-wayland}/bin/rofi -show drun";
      
      gaps = {
        inner = 8;
        outer = 0;
      };
      
      window = {
        border = 2;
        titlebar = false;
      };
      
      input = {
        "type:keyboard" = {
          xkb_options = "caps:super";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
        };
      };
      
      output = {
        "*" = {};
      };
      
      keybindings = let
        mod = "Mod4";
      in {
        # Terminal and launcher
        "${mod}+Return" = "exec konsole";
        "${mod}+r" = "exec ${pkgs.rofi-wayland}/bin/rofi -show drun";
        "${mod}+c" = "kill";
        
        # File manager
        "${mod}+e" = "exec dolphin";
        
        # Screenshot
        "${mod}+Shift+s" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
        "Print" = "exec ${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy";
        
        # Lock
        "${mod}+l" = "exec ${pkgs.swaylock}/bin/swaylock -f -c 000000";
        
        # Focus
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+semicolon" = "focus right";
        
        # Move
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";
        
        # Workspaces
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";
        
        # Move to workspace
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";
        
        # Layout
        "${mod}+b" = "splith";
        "${mod}+v" = "splitv";
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+t" = "layout toggle split";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+a" = "focus parent";
        
        # Reload/Exit
        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+e" = "exec swaynag -t warning -m 'Exit sway?' -B 'Yes' 'swaymsg exit'";
        
        # Volume
        "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        
        # Brightness
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
      };
      
      bars = []; # Using waybar instead
      
      startup = [
        { command = "${pkgs.waybar}/bin/waybar"; }
        { command = "${pkgs.swww}/bin/swww init && sleep 1 && ${pkgs.swww}/bin/swww img $(ls ~/.local/share/wallpapers/*.{jpg,png,jpeg} 2>/dev/null | shuf -n1)"; }
        { command = "${pkgs.kanshi}/bin/kanshi"; }
        { command = "${pkgs.mako}/bin/mako"; }
        { command = "fcitx5 -d"; }
      ];
    };
  };

  # Waybar
  programs.waybar = {
    enable = true;
    # Config is in dotfiles/waybar
  };

  # Rofi launcher
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  # Sway-specific packages
  home.packages = with pkgs; [
    # Sway essentials
    swaylock
    swayidle
    swww
    swaybg
    
    # Screenshot/clipboard
    grim
    slurp
    wl-clipboard
    cliphist
    
    # Display management
    kanshi
    wlr-randr
    
    # Notifications
    mako
    libnotify
    
    # Brightness/Audio
    brightnessctl
    playerctl
    pamixer
    
    # Utils for scripts
    jq
    socat
    
    # GTK Themes (from nixpkgs - no binary files needed)
    flat-remix-gtk
    layan-gtk-theme
    nordic
    
    # Cursor themes
    bibata-cursors
    nordzy-cursor-theme
    vimix-cursor-theme
    whitesur-cursors
    
    # Icon themes
    flat-remix-icon-theme
    nordzy-icon-theme
    papirus-icon-theme

    # Additional GTK themes
    catppuccin-gtk
  ];

  # Config files from dotfiles
  xdg.configFile = {
    "waybar" = {
      source = ../../dotfiles/waybar;
      recursive = true;
    };
    "rofi" = {
      source = ../../dotfiles/rofi;
      recursive = true;
    };
    "kanshi/config".source = ../../dotfiles/kanshi/config;
  };

  # Wallpapers (shared with KDE)
  home.file.".local/share/wallpapers" = {
    source = ../../dotfiles/wallpapers;
    recursive = true;
  };

  # Themes and icons now come from Nix packages (home.packages above)
  # No need for manual .themes/.icons directories

  # Environment variables for Wayland
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
  };

  # Swayidle config
  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -f -c 000000"; }
      { timeout = 600; command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'"; resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'"; }
    ];
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f -c 000000"; }
    ];
  };

  # Kanshi display management
  services.kanshi = {
    enable = true;
  };

  # Mako notifications
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    borderRadius = 5;
  };
}
