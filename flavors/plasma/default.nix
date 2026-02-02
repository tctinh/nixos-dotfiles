{ ... }: {
  imports = [
    ./kde-apps.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/shell.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/packages.nix
  ];
}
