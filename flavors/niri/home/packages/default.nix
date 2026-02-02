{ pkgs, ... }:
{
  users.users.tctinh.packages = with pkgs; [
    # Browsers
    microsoft-edge
    google-chrome

    # Communication
    discord
    teams-for-linux
    thunderbird

    # Media
    vlc
    ytmdesktop

    # Office
    libreoffice-qt6-fresh

    # Dev
    zed-editor
    mongodb-compass

    # CLI helpers
    jq
    gh
    fastfetch
  ];
}
