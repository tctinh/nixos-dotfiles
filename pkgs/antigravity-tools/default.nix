{ lib, stdenv, fetchurl, appimageTools }:

let
  pname = "antigravity-tools";
  version = "3.3.48";

  arch =
    if stdenv.hostPlatform.isx86_64 then
      "amd64"
    else
      throw "${pname} is currently packaged only for x86_64-linux (no arm64 AppImage found for ${version}).";

  src = fetchurl {
    url = "https://github.com/lbjlaq/Antigravity-Manager/releases/download/v${version}/Antigravity.Tools_${version}_${arch}.AppImage";
    hash = "sha256-LkOdGr4JUkMsU1lfTIwzpZ9oVP0Qiy8Bjrjm1rToMJM=";
  };

  appimage = appimageTools.wrapType2 {
    inherit pname version src;

    # AppImages often rely on host libs on NixOS; provide the common ones.
    extraPkgs = pkgs: with pkgs; [
      gtk3
      webkitgtk_4_1
      libsoup_3
      openssl
      zlib
      libayatana-appindicator
    ];
  };
in
appimage.overrideAttrs (old: {
  meta = (old.meta or { }) // {
    description = "Antigravity Tools (Antigravity-Manager)";
    homepage = "https://github.com/lbjlaq/Antigravity-Manager";
    license = lib.licenses.cc-by-nc-sa-40;
    platforms = [ "x86_64-linux" ];
    mainProgram = "antigravity-tools";
  };
})
