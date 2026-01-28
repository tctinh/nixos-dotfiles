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
    # caprine - installed via flake with X11 flag for Vietnamese input
    teams-for-linux
    thunderbird

    # Office
    libreoffice-qt6-fresh

    # Database tools
    mongodb-compass
  ];
}
