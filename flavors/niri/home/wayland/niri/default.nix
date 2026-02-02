{ ... }:
{
  programs.niri.enable = true;

  environment.etc."niri/config.kdl".text = ''
    input {
      "*" {
        xkb {
          layout "us"
        }
        repeat-delay 250
        repeat-rate 30
      }
    }

    layout {
      gaps 5
      background-color "transparent"
    }

    layer-rule {
      match namespace="^quickshell$"
      place-within-backdrop true
    }

    layer-rule {
      match namespace="dms:blurwallpaper"
      place-within-backdrop true
    }

    environment {
      XDG_CURRENT_DESKTOP "niri"
      QT_QPA_PLATFORM "wayland"
      ELECTRON_OZONE_PLATFORM_HINT "auto"
      QT_QPA_PLATFORMTHEME "gtk3"
      QT_QPA_PLATFORMTHEME_QT6 "gtk3"
    }

    spawn-at-startup "bash" "-c" "wl-paste --watch cliphist store &"

    binds {
      Mod+Space hotkey-overlay-title="Application Launcher" {
        spawn "dms" "ipc" "call" "spotlight" "toggle"
      }
      Mod+N hotkey-overlay-title="Notification Center" {
        spawn "dms" "ipc" "call" "notifications" "toggle"
      }
      Mod+Comma hotkey-overlay-title="Settings" {
        spawn "dms" "ipc" "call" "settings" "focusOrToggle"
      }
      Mod+P hotkey-overlay-title="Notepad" {
        spawn "dms" "ipc" "call" "notepad" "toggle"
      }
      Mod+X hotkey-overlay-title="Power Menu" {
        spawn "dms" "ipc" "call" "powermenu" "toggle"
      }
      Mod+Alt+L hotkey-overlay-title="Lock Screen" {
        spawn "dms" "ipc" "call" "lock" "lock"
      }
      Mod+V hotkey-overlay-title="Clipboard Manager" {
        spawn "dms" "ipc" "call" "clipboard" "toggle"
      }

      XF86AudioRaiseVolume allow-when-locked=true {
        spawn "dms" "ipc" "call" "audio" "increment" "3"
      }
      XF86AudioLowerVolume allow-when-locked=true {
        spawn "dms" "ipc" "call" "audio" "decrement" "3"
      }
      XF86AudioMute allow-when-locked=true {
        spawn "dms" "ipc" "call" "audio" "mute"
      }
      XF86MonBrightnessUp allow-when-locked=true {
        spawn "dms" "ipc" "call" "brightness" "increment" "5" ""
      }
      XF86MonBrightnessDown allow-when-locked=true {
        spawn "dms" "ipc" "call" "brightness" "decrement" "5" ""
      }
    }

    window-rule {
      match app-id=r#"^org\.gnome\."#
      draw-border-with-background false
      geometry-corner-radius 12
      clip-to-geometry true
    }

    window-rule {
      match app-id=r#"^org\.wezfurlong\.wezterm$"#
      match app-id="Alacritty"
      match app-id="zen"
      match app-id="com.mitchellh.ghostty"
      match app-id="kitty"
      draw-border-with-background false
    }

    window-rule {
      match is-active=false
      opacity 0.9
    }

    window-rule {
      geometry-corner-radius 12
      clip-to-geometry true
    }

    window-rule {
      match app-id=r#"org.quickshell$"#
      open-floating true
    }

    include "dms/colors.kdl"
    include "dms/layout.kdl"
    include "dms/alttab.kdl"
    include "dms/binds.kdl"
  '';

  environment.etc."niri/dms/colors.kdl".text = "";
  environment.etc."niri/dms/layout.kdl".text = "";
  environment.etc."niri/dms/alttab.kdl".text = "";
  environment.etc."niri/dms/binds.kdl".text = "";
}
