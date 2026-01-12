# NixOS Dotfiles

Personal NixOS configuration with Home Manager and Plasma Manager for a fully declarative desktop setup.

## 📁 Repository Structure

```
nixos-dotfiles/
├── flake.nix                 # Main flake - entry point
├── flake.lock                # Locked dependencies
├── hosts/
│   └── nixos/
│       ├── configuration.nix # System configuration
│       └── hardware-configuration.nix
├── home/
│   └── tctinh.nix            # Home Manager config with plasma-manager
├── modules/
│   ├── nixos/                # Reusable NixOS modules
│   └── home-manager/         # Reusable Home Manager modules
└── dotfiles/                 # Reference copies of dotfiles
    ├── kde/                  # KDE config files (for reference)
    ├── fcitx5/               # Vietnamese input method
    └── fish/                 # Fish shell config
```

## 🚀 Quick Start

### Fresh Install

1. Clone this repo:
   ```bash
   git clone https://github.com/tctinh/nixos-dotfiles.git ~/nixos-dotfiles
   cd ~/nixos-dotfiles
   ```

2. Apply NixOS configuration:
   ```bash
   sudo nixos-rebuild switch --flake .#nixos
   ```

### Updating

```bash
# Update all flake inputs
nix flake update

# Rebuild system
sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos

# Or use the alias
update
```

## 🎨 Features

### System
- **NixOS 25.11** with flakes
- **KDE Plasma 6** desktop environment
- **NVIDIA Optimus** (hybrid AMD + NVIDIA)
- **Docker** (rootless)
- **Waydroid** for Android apps
- **Steam** and **Lutris** for gaming

### Desktop (Declarative via plasma-manager)
- **Theme:** Catppuccin Macchiato (Dark)
- **Icons:** Papirus-Dark
- **Cursor:** Bibata-Modern-Ice
- **Font:** Noto Sans + FantasqueSansM Nerd Font (terminal)
- **Shortcuts:** Meta+1/2/3 for desktops, Meta+Return for terminal

### Input Method
- **Fcitx5 + Bamboo** for Vietnamese typing

## ⌨️ Key Bindings

| Shortcut | Action |
|----------|--------|
| `Meta+1/2/3` | Switch to Desktop 1/2/3 |
| `Meta+Return` | Launch Konsole |
| `Meta+E` | Launch Dolphin |
| `Meta+D` | Show Desktop |
| `Meta+W` | Overview |
| `Meta+G` | Grid View |
| `Meta+L` | Lock Screen |

## 📦 Included Packages

### System-wide
- Development: `git`, `gh`, `nodejs`, `vim`, `vscode`
- Browsers: `firefox`, `microsoft-edge`
- Gaming: `steam`, `lutris`, `discord`
- Productivity: `libreoffice`, `teams-for-linux`
- Utilities: `fastfetch`, `htop`, `jq`, `wget`

### User (via Home Manager)
- `prime-run` script for NVIDIA offloading
- KDE theming packages (Kvantum, Catppuccin, etc.)

## 🔧 Customization

### Adding a new host

1. Create `hosts/<hostname>/configuration.nix`
2. Add to `flake.nix`:
   ```nix
   nixosConfigurations.<hostname> = nixpkgs.lib.nixosSystem { ... };
   ```

### Modifying KDE settings

Edit `home/tctinh.nix` under `programs.plasma`. Common sections:
- `workspace` - Theme, icons, cursor
- `panels` - Panel layout and widgets
- `shortcuts` - Keyboard shortcuts
- `kwin` - Window manager settings

### Converting existing KDE settings to Nix

Use the `rc2nix` tool:
```bash
nix run github:nix-community/plasma-manager
```

## 📝 Notes

- The `dotfiles/kde/` directory contains reference copies of KDE configs
- These are NOT applied automatically - they're for reference when converting to plasma-manager
- Sensitive files (SSH keys, credentials) are NOT tracked

## 🔗 References

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Plasma Manager](https://github.com/nix-community/plasma-manager)
- [Catppuccin Theme](https://github.com/catppuccin/catppuccin)

## 📄 License

MIT
