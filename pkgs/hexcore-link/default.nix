{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  buildFHSEnv,
  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  atk,
  cairo,
  cups,
  dbus,
  expat,
  fontconfig,
  freetype,
  gdk-pixbuf,
  glib,
  gtk3,
  harfbuzz,
  libappindicator-gtk3,
  libdrm,
  libGL,
  libgbm,
  libnotify,
  libxkbcommon,
  mesa,
  nspr,
  nss,
  pango,
  systemd,
  vulkan-loader,
  xorg,
}:

let
  pname = "hexcore-link";
  version = "2.5.9";

  src = fetchurl {
    url = "https://pub-0ff293aefb644607ac910219d9762b50.r2.dev/HexcoreLink_${version}_x64.tar.gz";
    sha256 = "726f2062d2446d2101e6b2eec5e95d186c1a0a15e21ede69e5ff573ec30d24e9";
  };

  hexcore-unwrapped = stdenv.mkDerivation {
    inherit pname version src;

    dontConfigure = true;
    dontBuild = true;
    dontPatchELF = true;
    dontStrip = true;

    unpackPhase = ''
      runHook preUnpack
      tar -xzf $src
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/opt/hexcore-link
      cp -r HexcoreLink_${version}_x64/* $out/opt/hexcore-link/
      chmod +x $out/opt/hexcore-link/hexcore-link
      
      # Desktop file
      mkdir -p $out/share/applications
      cat > $out/share/applications/hexcore-link.desktop << EOF
[Desktop Entry]
Name=Hexcore Link
Comment=Hexcore Link for ANNE PRO 2D and other keyboards
Exec=hexcore-link %U
Icon=hexcore-link
Terminal=false
Type=Application
Categories=Utility;Settings;
StartupWMClass=hexcore-link
EOF

      # Icon
      mkdir -p $out/share/icons/hicolor/256x256/apps
      cp $out/opt/hexcore-link/resources/icons/tray.png $out/share/icons/hicolor/256x256/apps/hexcore-link.png

      # Licenses
      mkdir -p $out/share/licenses/hexcore-link
      cp $out/opt/hexcore-link/LICENSES.chromium.html $out/share/licenses/hexcore-link/
      cp $out/opt/hexcore-link/LICENSE.electron.txt $out/share/licenses/hexcore-link/
      
      runHook postInstall
    '';
  };

in buildFHSEnv {
  name = "hexcore-link";
  
  targetPkgs = pkgs: [
    hexcore-unwrapped
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    harfbuzz
    libappindicator-gtk3
    libdrm
    libGL
    libgbm
    libnotify
    libxkbcommon
    mesa
    nspr
    nss
    pango
    systemd
    vulkan-loader
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    xorg.libxshmfence
  ];

  runScript = ''
    /opt/hexcore-link/hexcore-link --ozone-platform=x11 --use-angle=swiftshader --use-gl=angle "$@"
  '';

  extraInstallCommands = ''
    mkdir -p $out/share
    ln -s ${hexcore-unwrapped}/share/applications $out/share/applications
    ln -s ${hexcore-unwrapped}/share/icons $out/share/icons
    ln -s ${hexcore-unwrapped}/share/licenses $out/share/licenses
  '';

  meta = with lib; {
    description = "Hexcore Link for ANNE PRO 2D and other keyboards (firmware > 3.0)";
    homepage = "https://www.hexcore.xyz/hexcore-link";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "hexcore-link";
  };
}
