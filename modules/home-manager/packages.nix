{ pkgs, ... }: {
  # User-specific packages (not system-wide)
  home.packages = with pkgs; [
    # Clipboard helpers (tmux copy-mode -> system clipboard)
    wl-clipboard

    # Editors
    zed-editor

    # Browsers
    microsoft-edge
    google-chrome

    # Media
    vlc
    ytmdesktop

    # Communication
    discord
    teams-for-linux
    thunderbird

    # Office
    libreoffice-qt6-fresh

    # Database tools
    mongodb-compass
  ];
}
