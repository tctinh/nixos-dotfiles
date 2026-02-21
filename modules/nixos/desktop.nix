{ pkgs, username, ... }: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Auto-unlock KDE Wallet on login
  security.pam.services.${username}.kwallet = {
    enable = true;
    package = pkgs.kdePackages.kwallet-pam;
  };

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="6696", ATTRS{idProduct}=="2028", MODE="0666"
  '';

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Required for screen sharing on Wayland (if you use it)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
