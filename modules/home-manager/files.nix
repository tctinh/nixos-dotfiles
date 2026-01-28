{ ... }:
let
  # Chromium-based apps (Chrome/Edge/Chromium): enable Wayland IME
  waylandImeFlags = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
    --enable-wayland-ime
    --wayland-text-input-version=3
  '';

  # Electron apps with flaky Wayland IME: force X11/XWayland
  x11Flags = ''
    --ozone-platform=x11
  '';
in {
  xdg.enable = true;

  # Electron/Chromium apps need these flags for native Wayland IME support
  home.file.".config/chrome-flags.conf".text = waylandImeFlags;
  home.file.".config/chromium-flags.conf".text = waylandImeFlags;
  home.file.".config/microsoft-edge-stable-flags.conf".text = waylandImeFlags;
  home.file.".config/google-chrome-dev-flags.conf".text = waylandImeFlags;

  # Teams for Linux (Electron)
  home.file.".config/teams-for-linux-flags.conf".text = x11Flags;

  # Ghostty terminal configuration
  home.file.".config/ghostty/config".text = ''
    # Shell
    command = zsh

    # Font
    font-family = JetBrainsMono Nerd Font
    font-size = 11

    # Theme
    theme = Nord

    # Window
    window-padding-x = 8
    window-padding-y = 8
    window-decoration = true

    # Cursor
    cursor-style = block
    cursor-style-blink = true

    # Misc
    copy-on-select = clipboard
    confirm-close-surface = false
  '';

  # Konsole profiles (colorschemes, etc.)
  home.file.".local/share/konsole" = {
    source = ../../dotfiles/konsole;
    recursive = true;
  };

  # Force Electron apps to X11/XWayland via user desktop-entry overrides.
  # This is necessary because some Nixpkgs wrappers add Wayland flags directly
  # (e.g. --ozone-platform-hint=auto --enable-wayland-ime=true), bypassing
  # the *-flags.conf mechanism.
  xdg.desktopEntries = {
    code = {
      name = "Visual Studio Code";
      exec = "code --ozone-platform=x11 %F";
      icon = "vscode";
      terminal = false;
      type = "Application";
      categories = [ "Development" "IDE" ];
    };
    "teams-for-linux" = {
      name = "Teams for Linux";
      exec = "teams-for-linux --ozone-platform=x11 %U";
      icon = "teams-for-linux";
      terminal = false;
      type = "Application";
      categories = [ "Network" "InstantMessaging" ];
    };
    discord = {
      name = "Discord";
      exec = "discord --ozone-platform=x11 %U";
      icon = "discord";
      terminal = false;
      type = "Application";
      categories = [ "Network" "InstantMessaging" ];
    };
    "mongodb-compass" = {
      name = "MongoDB Compass";
      exec = "mongodb-compass --ozone-platform=x11 %U";
      icon = "mongodb-compass";
      terminal = false;
      type = "Application";
      categories = [ "Development" "Database" ];
    };
    "google-chrome" = {
      name = "Google Chrome";
      exec = "google-chrome-stable --ozone-platform=x11 %U";
      icon = "google-chrome";
      terminal = false;
      type = "Application";
      categories = [ "Network" "WebBrowser" ];
      mimeType = [
        "text/html"
        "text/xml"
        "application/xhtml+xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
    };
    # Hide the default Wayland Chrome entry
    "com.google.Chrome" = {
      name = "Google Chrome (Hidden)";
      exec = "";
      noDisplay = true;
    };
  };
}
