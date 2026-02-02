{ config, pkgs, ... }:
let
  niriSession = pkgs.stdenvNoCC.mkDerivation {
    pname = "niri-session";
    version = "1";
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/wayland-sessions
      cat > $out/share/wayland-sessions/niri.desktop <<'EOF'
      [Desktop Entry]
      Name=Niri
      Comment=Niri Wayland session
      Exec=${pkgs.niri}/bin/niri-session
      Type=Application
      EOF
    '';
    passthru.providedSessions = [ "niri" ];
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.displayManager.sessionPackages = [
    niriSession
  ];

  security.pam.services.sddm = {
    fprintAuth = true;
    rules.auth = {
      fprintd.order = config.security.pam.services.sddm.rules.auth.unix.order - 10;
    };
  };
}
