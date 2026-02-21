{ ... }: {
  # NetworkManager handles WiFi (KDE Plasma provides the UI)
  networking.networkmanager.enable = true;

  # Remote access mesh network
  services.tailscale.enable = true;
}
