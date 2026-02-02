{ pkgs, ... }: {
  programs.niri.enable = true;
  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.niri.default = [ "gnome" "gtk" ];
  };
}
