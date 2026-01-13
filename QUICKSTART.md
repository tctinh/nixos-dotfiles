# Quickstart Guide

This repo is a **portable NixOS configuration**. You manage your entire system from here - no need to edit `/etc/nixos/configuration.nix`.

## Prerequisites

- NixOS installed with flakes enabled
- Git

## Quick Commands

```bash
# Apply system + home-manager configuration
sudo nixos-rebuild switch --flake .#nixos

# Test build without applying
sudo nixos-rebuild dry-build --flake .#nixos

# Validate syntax
nix flake check

# Update all inputs (nixpkgs, home-manager, etc.)
nix flake update

# Enter development shell (nil LSP + nixfmt)
nix develop
```

## First-Time Setup

1. **Clone the repo:**
   ```bash
   git clone <your-repo-url> ~/nixos-dotfiles
   cd ~/nixos-dotfiles
   ```

2. **Copy your hardware configuration:**
   ```bash
   cp /etc/nixos/hardware-configuration.nix hosts/nixos/
   ```

3. **Update personal settings:**
   - Edit `hosts/nixos/configuration.nix`:
     - Update `networking.hostName` if needed
     - Update `users.users.tctinh` to your username
     - Update `programs.git.config.user.email`
   - Edit `home/tctinh.nix`:
     - Update `home.username` and `home.homeDirectory`

4. **Apply the configuration:**
   ```bash
   sudo nixos-rebuild switch --flake .#nixos
   ```

## Adding a New Host

1. Create a new directory: `hosts/<hostname>/`
2. Copy `configuration.nix` and `hardware-configuration.nix`
3. Customize for the new machine
4. Add to `flake.nix`:
   ```nix
   nixosConfigurations.<hostname> = nixpkgs.lib.nixosSystem {
     # ...
   };
   ```
5. Apply: `sudo nixos-rebuild switch --flake .#<hostname>`

## Module Structure

```
modules/
├── nixos/                    # System-level modules
│   ├── default.nix           # Aggregator (imports all)
│   ├── desktop.nix           # KDE Plasma + SDDM
│   ├── audio.nix             # PipeWire
│   ├── nvidia.nix            # NVIDIA Optimus/Prime
│   ├── networking.nix        # NetworkManager + hosts
│   ├── fcitx5.nix            # Vietnamese input
│   ├── shell.nix             # Bash + oh-my-bash
│   ├── virtualization.nix    # Docker + Waydroid
│   ├── gaming.nix            # Steam + Lutris
│   └── packages.nix          # System packages
└── home-manager/             # User-level modules
    ├── default.nix           # Aggregator
    ├── plasma.nix            # KDE workspace config
    ├── packages.nix          # User apps (editors, browsers)
    └── files.nix             # Wallpapers + dotfiles
```

## Customization

- **Add system packages:** Edit `modules/nixos/packages.nix`
- **Add user apps:** Edit `modules/home-manager/packages.nix`
- **Change KDE settings:** Edit `modules/home-manager/plasma.nix`
- **Add shell aliases:** Edit `modules/nixos/shell.nix`

## Troubleshooting

**Build fails with syntax error:**
```bash
nix flake check
```

**See what would change:**
```bash
sudo nixos-rebuild dry-build --flake .#nixos
```

**Rollback to previous generation:**
```bash
sudo nixos-rebuild switch --rollback
```
