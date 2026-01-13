{ pkgs, ... }: {
  # Enable Sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # XDG portal for screen sharing and file dialogs
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Required for sway
  security.polkit.enable = true;

  # Swaylock PAM (auto-enabled with programs.sway.enable, but explicit)
  security.pam.services.swaylock = {};

  # Brightness control
  programs.light.enable = true;
}
