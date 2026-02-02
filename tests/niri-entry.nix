let
  hostPath = ../hosts/nixos/niri.nix;
  hostExists = builtins.pathExists hostPath;
  hostContent = if hostExists then builtins.readFile hostPath else "";
  normalized = builtins.replaceStrings ["\n" "\r"] [" " " "] hostContent;
  matches = pattern: builtins.match (".*" + pattern + ".*") normalized != null;
  missingImports = builtins.filter (needle: !(matches needle)) [
    "flavors/shared"
    "flavors/niri"
  ];
  hasCachyKernel = matches "linuxPackages_cachyos";
  hasFishShell = matches "users.defaultUserShell = pkgs.fish"
    || matches "shell = pkgs.fish";
  hasKdeReferences = matches "plasma" || matches "kde";
in
if !hostExists then
  throw "Missing hosts/nixos/niri.nix"
else if missingImports != [] then
  throw "Missing imports in hosts/nixos/niri.nix: ${builtins.concatStringsSep ", " missingImports}"
else if !hasCachyKernel then
  throw "Expected linuxPackages_cachyos in hosts/nixos/niri.nix"
else if !hasFishShell then
  throw "Expected fish shell configuration in hosts/nixos/niri.nix"
else if hasKdeReferences then
  throw "hosts/nixos/niri.nix should not reference KDE or Plasma"
else
  "niri host entry present"
