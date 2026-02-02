{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../flavors/shared
    ../../flavors/plasma
  ];

  networking.hostName = "nixos-plasma";
  time.timeZone = "Asia/Ho_Chi_Minh";

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.tctinh = {
    isNormalUser = true;
    description = "tctinh";
    extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" "input" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  home-manager.users.tctinh = import ../../home/tctinh.nix;

  system.stateVersion = "24.11";
}
