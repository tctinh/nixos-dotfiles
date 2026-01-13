{ pkgs, ... }: {
  # Fingerprint authentication
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix-550a;
    };
  };

  # Enable fingerprint for SDDM login
  security.pam.services.sddm.fprintAuth = true;
}
