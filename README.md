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

## Flavors

This flake provides two desktop flavors that share the same base system:

- **Plasma**: KDE Plasma 6 with KDE apps and plasma-manager configuration.
- **Niri**: Niri Wayland compositor with Dank Material Shell (DMS) bar and Fish shell.

Switching flavors is just a different flake target; both flavors remain available.

## Quick Commands

```bash
# Apply configuration (pick a flavor)
sudo nixos-rebuild switch --flake .#plasma
sudo nixos-rebuild switch --flake .#niri

# Test build
sudo nixos-rebuild dry-build --flake .#plasma
sudo nixos-rebuild dry-build --flake .#niri

# Update inputs
nix flake update

# Development shell
nix develop

# Python dev shells
nix develop .#py312
nix develop .#py313
nix develop .#py314
nix develop .#py315

# Optional: justfile shortcuts
just switch-plasma
just switch-niri
just build-plasma
just build-niri
```

## Python

This repo installs multiple Python versions side-by-side and provides flake dev shells per version.

- **System interpreters**: `python3.12`, `python3.13`, `python3.14`, `python3.15`
- **Per-project shells** (recommended): `nix develop .#py313` (or `.#py312`, `.#py314`, `.#py315`)
- **Dependency workflow**: use `uv` inside the dev shell to manage a local `.venv`
    - Create venv: `uv venv --python python3.13`
    - Install deps (if using `pyproject.toml`): `uv sync`

## Features

### System
- **NixOS 24.11** with flakes
- **KDE Plasma 6** desktop environment (plasma flavor)
- **Niri** Wayland compositor with **Dank Material Shell** (niri flavor)
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

## Flavor Differences

### Plasma flavor (KDE)
- Desktop: KDE Plasma 6
- Shell: Bash
- File manager: **Dolphin**
- Terminal: **Konsole**
- Plasma theming via plasma-manager

### Niri flavor
- Desktop: **Niri** + **Dank Material Shell (DMS)** bar
- Shell: **Fish**
- File manager: **Yazi** (no KDE apps)
- Terminal: **WezTerm**
- Keybinds and DMS IPC actions are defined in the Niri config

> Note: Niri intentionally excludes KDE apps to keep the environment lean.

## Switching Flavors

Both flavors are built from the same flake, so switching is just a rebuild:

```bash
sudo nixos-rebuild switch --flake .#plasma
sudo nixos-rebuild switch --flake .#niri
```

If you use the provided `justfile`:

```bash
just switch-plasma
just switch-niri
```

## Troubleshooting

- **DMS bar not showing in Niri**: confirm `dank-material-shell` service is enabled and the Niri config includes the DMS config and keybinds. Rebuild and restart the session.
- **NVIDIA quirks**: verify the plasma flavor if you need KDE + NVIDIA stability; use the Niri flavor only after confirming the compositor works for your GPU.
- **Missing KDE apps in Niri**: this is expected. Use Niri alternatives (Yazi, WezTerm) or switch back to Plasma.
- **Vietnamese input not working**: ensure `fcitx5` is running and Bamboo is selected; log out/in after rebuild.

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
