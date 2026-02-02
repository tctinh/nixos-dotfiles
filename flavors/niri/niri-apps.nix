{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # File manager (TUI)
    yazi

    # Terminal emulators
    ghostty
    foot

    # Text editors
    zed-editor
    helix

    # Image viewer
    imv

    # Document viewer
    zathura

    # Archive tools
    file-roller
    p7zip
    unzip
    unrar

    # Clipboard manager
    wl-clipboard
    cliphist

    # Screenshot tools
    grim
    slurp
    swappy

    # Screen locker
    swaylock-effects

    # Idle management
    swayidle

    # Notification daemon (backup)
    mako

    # Polkit agent
    polkit_gnome

    # Qt platform plugins for non-KDE Qt apps
    libsForQt5.qt5ct
    qt6Packages.qt6ct
  ];
}
