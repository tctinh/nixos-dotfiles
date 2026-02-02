{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../flavors/shared
    ../../flavors/niri
    # Chaotic-Nyx for CachyOS kernel and other bleeding-edge packages
    inputs.chaotic.nixosModules.default
  ];

  networking.hostName = "nixos-niri";
  time.timeZone = "Asia/Ho_Chi_Minh";

  nixpkgs.config.allowUnfree = true;

  # Boot loader (kernel config in flavors/niri/core/boot.nix)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  system.stateVersion = "24.11";
}
