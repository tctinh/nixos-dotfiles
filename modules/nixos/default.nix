{ ... }: {
  imports = [
    ./desktop.nix
    ./audio.nix
    ./nvidia.nix
    ./networking.nix
    ./fcitx5.nix
    ./shell.nix
    ./virtualization.nix
    ./gaming.nix
    ./packages.nix
    ./sway.nix
    ./fprintd.nix
    ./fonts.nix
    ./power.nix
  ];
}
