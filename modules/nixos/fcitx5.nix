{ pkgs, ... }: {
  # Session environment variables so GTK/Qt/Wayland sessions use fcitx5.
  # Consolidated from environment.sessionVariables and environment.variables
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    IM_CONFIG_PHASE = "1";
  };

  # Configure fcitx5 via the NixOS inputMethod option.
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-bamboo
        # KDE/Qt integration
        kdePackages.fcitx5-qt
        kdePackages.fcitx5-configtool
      ];
    };
  };
}
