{ ... }: {
  imports = [
    ./audio.nix
    ./fcitx5.nix
    ./networking.nix
    ./virtualization.nix
    ./hardware/bluetooth.nix
    ./hardware/fprintd.nix
    ./hardware/nvidia.nix
    ./hardware/power.nix
  ];
}
