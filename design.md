# Design

## Overview
Add a small NixOS module that enables the BlueZ Bluetooth stack and turns on controllers at boot. Because this system is a KDE Plasma desktop, KDE’s built-in Bluetooth UI is expected to be available for pairing; Blueman is enabled as an additional GUI that can coexist with KDE (useful for troubleshooting and extra device details).

## Architecture
- New module: `modules/nixos/bluetooth.nix`
- Imported by: `modules/nixos/default.nix` aggregator

## NixOS Options
- `hardware.bluetooth.enable = true;`
- `hardware.bluetooth.powerOnBoot = true;`
- `hardware.bluetooth.settings`:
  - `General.Experimental = true;` (battery reporting and other features; stable on NixOS 24.11+)
  - `General.FastConnectable = true;`
  - `Policy.AutoEnable = true;`
- `services.blueman.enable = true;` (optional GUI; harmless alongside KDE)

## Considerations
- Audio: Bluetooth audio is handled by PipeWire already enabled in `modules/nixos/audio.nix`.
- Security: Bluetooth management happens via system services and desktop UI; no extra user group changes are required.
