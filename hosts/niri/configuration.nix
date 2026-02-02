{ lib, ... }:

{
  imports = [
    ../nixos/configuration.nix
  ];

  networking.hostName = lib.mkForce "niri";
}
