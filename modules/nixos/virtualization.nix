{ ... }: {
  # Enable Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Enable Waydroid
  virtualisation.waydroid.enable = true;
}
