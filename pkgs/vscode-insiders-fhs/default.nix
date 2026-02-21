{
  vscode-insiders,
  buildFHSEnv,
  makeDesktopItem,
  cacert,
}:

let
  vscode-insiders-fhs = buildFHSEnv {
    name = "code-insiders";
    targetPkgs = p: [
      vscode-insiders
      # Required for extensions with native binaries
      p.stdenv.cc.cc.lib
      p.zlib
      p.openssl
      p.curl
      p.libsecret
      p.libkrb5
      p.icu
      # Network/auth for syncing
      p.glib
      p.nss
      p.nspr
      p.atk
      p.cups
      p.dbus
      p.expat
      p.libdrm
      p.libxkbcommon
      p.pango
      p.cairo
      p.mesa
      p.alsa-lib
      # Additional deps from wiki
      p.krb5
      p.libsoup_3
      p.webkitgtk_4_1
    ];
    runScript = "code-insiders";
    profile = ''
      export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
    '';
  };

  vscode-insiders-desktop = makeDesktopItem {
    name = "code-insiders";
    desktopName = "Visual Studio Code - Insiders";
    comment = "Code Editing. Redefined.";
    exec = "${vscode-insiders-fhs}/bin/code-insiders %F";
    icon = "vscode-insiders";
    terminal = false;
    categories = [ "Utility" "TextEditor" "Development" "IDE" ];
    mimeTypes = [ "text/plain" "inode/directory" ];
    startupNotify = true;
    startupWMClass = "Code - Insiders";
  };

in {
  inherit vscode-insiders-fhs vscode-insiders-desktop;
}
