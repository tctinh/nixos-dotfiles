{ pkgs, ... }: {
  # Wayland: native apps use text-input protocol directly
  # XMODIFIERS: for XWayland/X11 legacy apps
  # NIXOS_OZONE_WL: Electron apps use native Wayland
  environment.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    NIXOS_OZONE_WL = "1";
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      addons = with pkgs; [
        # GTK support (GTK2 + GTK3 + GTK4)
        (fcitx5-gtk.override { withGTK2 = true; })
        # Input methods
        fcitx5-mozc
        fcitx5-bamboo
        # KDE/Qt integration
        kdePackages.fcitx5-qt
        kdePackages.fcitx5-configtool
      ];
    };
  };
}
