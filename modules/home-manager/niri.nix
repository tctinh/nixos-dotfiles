{ ... }: {
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri:GNOME";
    SDL_VIDEODRIVER = "wayland";
    WLR_RENDERER = "vulkan";
    GTK_USE_PORTAL = "1";
  };
}
