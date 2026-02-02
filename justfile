default:
  @just --list

# Switch between flavors
switch-plasma:
  sudo nixos-rebuild switch --flake .#plasma

switch-niri:
  sudo nixos-rebuild switch --flake .#niri

# Test builds (no reboot)
build-plasma:
  sudo nixos-rebuild build --flake .#plasma

build-niri:
  sudo nixos-rebuild build --flake .#niri

# Update flake inputs
update:
  nix flake update

# Clean old generations
clean:
  sudo nix-collect-garbage -d
