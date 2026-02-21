{ pkgs, ... }: {
  # User-specific packages (not system-wide)
  home.packages = with pkgs; [
    # Editors
    zed-editor

    # Web and communication
    discord
    google-chrome
    teams-for-linux

    # Productivity
    libreoffice-qt6-fresh
    mongodb-compass

    # Media
    vlc
    ytmdesktop
  ];
}
