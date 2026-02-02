{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../flavors/shared
    ../../flavors/niri
  ];

  networking.hostName = "nixos-niri";
  time.timeZone = "Asia/Ho_Chi_Minh";

  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = inputs.chaotic.packages.${pkgs.system}.linuxPackages_cachyos;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  system.stateVersion = "24.11";
}
