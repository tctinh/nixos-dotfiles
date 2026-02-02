let
  requiredPaths = [
    ../flavors/niri/default.nix
    ../flavors/niri/niri-apps.nix
    ../flavors/niri/core/default.nix
    ../flavors/niri/core/boot.nix
    ../flavors/niri/core/security.nix
    ../flavors/niri/core/users.nix
    ../flavors/niri/hardware/default.nix
    ../flavors/niri/services/default.nix
    ../flavors/niri/services/pipewire.nix
    ../flavors/niri/services/dms.nix
    ../flavors/niri/programs/default.nix
    ../flavors/niri/programs/fish.nix
    ../flavors/niri/programs/fonts.nix
    ../flavors/niri/programs/xdg.nix
    ../flavors/niri/home/default.nix
    ../flavors/niri/home/terminal/default.nix
    ../flavors/niri/home/terminal/shell/fish.nix
    ../flavors/niri/home/terminal/shell/starship.nix
    ../flavors/niri/home/terminal/emulators/ghostty.nix
    ../flavors/niri/home/terminal/software/yazi.nix
    ../flavors/niri/home/terminal/software/zoxide.nix
    ../flavors/niri/home/terminal/software/atuin.nix
    ../flavors/niri/home/terminal/software/bat.nix
    ../flavors/niri/home/terminal/software/eza.nix
    ../flavors/niri/home/terminal/software/git.nix
    ../flavors/niri/home/wayland/niri/default.nix
    ../flavors/niri/home/packages/default.nix
    ../hosts/nixos/niri.nix
    ./niri-entry.nix
  ];
  greetdPath = ../flavors/niri/services/greetd.nix;
  servicesDefaultPath = ../flavors/niri/services/default.nix;
  servicesDefaultExists = builtins.pathExists servicesDefaultPath;
  servicesDefaultContent = if servicesDefaultExists then builtins.readFile servicesDefaultPath else "";
  servicesDefaultNormalized = builtins.replaceStrings ["\n" "\r"] [" " " "] servicesDefaultContent;
  servicesDefaultReferencesGreetd = builtins.match ".*greetd\\.nix.*" servicesDefaultNormalized != null;

  missing = builtins.filter (path: !(builtins.pathExists path)) requiredPaths;
  missingPaths = builtins.concatStringsSep ", " (map toString missing);
in
if missing != [] then
  throw "Missing niri flavor paths: ${missingPaths}"
else if builtins.pathExists greetdPath then
  throw "Expected flavors/niri/services/greetd.nix to be removed"
else if servicesDefaultReferencesGreetd then
  throw "Expected flavors/niri/services/default.nix to stop importing greetd.nix"
else "niri flavor paths present"
