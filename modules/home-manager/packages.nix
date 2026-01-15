{ pkgs, ... }: {
  # User-specific packages (not system-wide)
  home.packages = with pkgs; [
    # Editors
    zed-editor

    # Browsers
    microsoft-edge
    google-chrome

    # Media
    vlc

    # Communication
    discord
    teams-for-linux

    # Office
    libreoffice-qt6-fresh

    # Database tools
    mongodb-compass
  ];
}
