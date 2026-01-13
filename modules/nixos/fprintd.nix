{ pkgs, config, ... }: {
  # Fingerprint authentication
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix-550a;
    };
  };

  # Enable fingerprint for SDDM login with correct PAM ordering
  # fprintd must come BEFORE unix password auth for fingerprint-first login
  security.pam.services.sddm = {
    fprintAuth = true;
    rules.auth = {
      # Make fprintd sufficient and run before password
      fprintd.order = config.security.pam.services.sddm.rules.auth.unix.order - 10;
    };
  };
}
