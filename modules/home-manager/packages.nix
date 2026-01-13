{ pkgs, ... }: {
  # User-specific packages (not system-wide)
  home.packages = with pkgs; [
    # Editors
    zed-editor

    # Browsers
    microsoft-edge
    google-chrome

    # Communication
    teams-for-linux
    discord
  ];

  # Session variables
  home.sessionVariables = {
    EDITOR = "vim";
  };
}
