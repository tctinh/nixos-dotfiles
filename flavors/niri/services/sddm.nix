{ config, pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.displayManager.sessionPackages = [
    (pkgs.writeTextDir "share/wayland-sessions/niri.desktop" ''
      [Desktop Entry]
      Name=Niri
      Comment=Niri Wayland session
      Exec=${pkgs.niri}/bin/niri-session
      Type=Application
    '')
  ];

  security.pam.services.sddm = {
    fprintAuth = true;
    rules.auth = {
      fprintd.order = config.security.pam.services.sddm.rules.auth.unix.order - 10;
    };
  };
}
