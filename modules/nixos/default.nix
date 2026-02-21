{ ... }: {
  imports = [
    # Hardware and desktop
    ./audio.nix
    ./bluetooth.nix
    ./desktop.nix
    ./fcitx5.nix
    ./fonts.nix
    ./fprintd.nix
    ./gaming.nix
    ./networking.nix
    ./nvidia.nix

    # System behavior and tooling
    ./packages.nix
    ./power.nix
    ./security.nix
    ./shell.nix
    ./virtualization.nix
  ];
}
