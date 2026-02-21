{
  caprine,
  makeWrapper,
  makeDesktopItem,
  runCommand,
}:

let
  caprine-x11 = runCommand "caprine-x11" {
    nativeBuildInputs = [ makeWrapper ];
  } ''
    mkdir -p $out/bin
    makeWrapper ${caprine}/bin/caprine $out/bin/caprine \
      --add-flags "--ozone-platform=x11"
  '';

  caprine-x11-desktop = makeDesktopItem {
    name = "caprine";
    desktopName = "Caprine";
    comment = "Elegant Facebook Messenger desktop app";
    exec = "${caprine-x11}/bin/caprine %U";
    icon = "caprine";
    terminal = false;
    categories = [ "Network" "InstantMessaging" "Chat" ];
    mimeTypes = [ "x-scheme-handler/caprine" ];
    startupWMClass = "Caprine";
  };

in {
  inherit caprine-x11 caprine-x11-desktop;
}
