# NixOS Dotfiles

Personal NixOS configuration with Home Manager and Plasma Manager for a fully declarative desktop setup.

**See [QUICKSTART.md](QUICKSTART.md) for setup instructions.**

## Repository Structure

```
nixos-dotfiles/
├── flake.nix                     # Main flake - entry point
├── flake.lock                    # Locked dependencies
├── QUICKSTART.md                 # Setup guide
├── hosts/
│   └── nixos/
│       ├── configuration.nix     # Host-specific config (slim)
│       └── hardware-configuration.nix
├── home/
│   └── tctinh.nix                # User entry point (imports modules)
├── modules/
│   ├── nixos/                    # System modules
│   │   ├── default.nix           # Aggregator
│   │   ├── desktop.nix           # KDE Plasma + SDDM
│   │   ├── audio.nix             # PipeWire
│   │   ├── nvidia.nix            # NVIDIA Optimus/Prime
│   │   ├── networking.nix        # NetworkManager + hosts
│   │   ├── fcitx5.nix            # Vietnamese input
│   │   ├── shell.nix             # Bash + oh-my-bash
│   │   ├── virtualization.nix    # Docker + Waydroid
│   │   ├── gaming.nix            # Steam + Lutris
│   │   └── packages.nix          # System packages
│   └── home-manager/             # User modules
│       ├── default.nix           # Aggregator
│       ├── plasma.nix            # KDE workspace config
│       ├── packages.nix          # User apps
│       └── files.nix             # Wallpapers + dotfiles
└── dotfiles/                     # Reference configs
    ├── kde/                      # KDE config files
    └── fcitx5/                   # Vietnamese input method
```

## Quick Commands

```bash
# Apply configuration
sudo nixos-rebuild switch --flake .#nixos

# Test build
sudo nixos-rebuild dry-build --flake .#nixos

# Update inputs
nix flake update

# Development shell
nix develop
```

## Features

### System
- **NixOS 24.11** with flakes
- **KDE Plasma 6** desktop environment
- **NVIDIA Optimus** (hybrid AMD + NVIDIA)
- **Docker** (rootless)
- **Waydroid** for Android apps
- **Steam** and **Lutris** for gaming

### Desktop (via plasma-manager)
- **Theme:** Nordic / Catppuccin Macchiato
- **Icons:** Papirus-Dark
- **Cursor:** Bibata-Modern-Ice
- **Font:** Noto Sans + FantasqueSansM Nerd Font

### Input Method
- **Fcitx5 + Bamboo** for Vietnamese typing

## Key Bindings

| Shortcut | Action |
|----------|--------|
| `Meta+1/2/3` | Switch to Desktop 1/2/3 |
| `Meta+Return` | Launch Konsole |
| `Meta+E` | Launch Dolphin |
| `Meta+D` | Show Desktop |
| `Meta+W` | Overview |
| `Meta+L` | Lock Screen |

## Packages

### System-wide (`modules/nixos/packages.nix`)
- Core: `git`, `gh`, `nodejs`, `vim`, `wget`, `jq`
- Utilities: `fastfetch`, `htop`, `lshw`
- Office: `libreoffice`

### User (`modules/home-manager/packages.nix`)
- Editors: `zed-editor`
- Browsers: `microsoft-edge`
- Communication: `teams-for-linux`, `discord`

### Gaming (`modules/nixos/gaming.nix`)
- `steam`, `lutris`

## Customization

| Task | File |
|------|------|
| Add system packages | `modules/nixos/packages.nix` |
| Add user apps | `modules/home-manager/packages.nix` |
| Change KDE settings | `modules/home-manager/plasma.nix` |
| Add shell aliases | `modules/nixos/shell.nix` |
| Add new host | See QUICKSTART.md |

## References

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Plasma Manager](https://github.com/nix-community/plasma-manager)
- [NixOS Modules Wiki](https://nixos.wiki/wiki/NixOS_modules)

## License

MIT
