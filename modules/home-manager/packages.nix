{ pkgs, ... }: {
  # User-specific packages (not system-wide)
  home.packages = with pkgs; [
    # Editors
    zed-editor

    # Browsers
    microsoft-edge

    # Communication
    discord
  ];
}
