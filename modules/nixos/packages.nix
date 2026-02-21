{ pkgs, lib, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    # Core CLI
    gh
    git
    jq
    nodejs
    vim
    wget

    # Development toolchains
    bun
    gnumake
    python312
    (lib.meta.lowPrio python313)
    (lib.meta.lowPrio python314)
    (lib.meta.lowPrio python315)
    uv
    zig

    # Desktop and productivity apps
    ghostty
    remmina
    via

    # Gaming and graphics tools
    appimage-run
    goverlay
    lact
    mangohud
    protonplus
    vkbasalt
    vulkan-tools

    # System observability and hardware
    fastfetch
    htop
    lenovo-legion
    lm_sensors
    lshw

    # Filesystem and disk tools
    btrfs-progs
    kdePackages.partitionmanager

    # Utilities
    android-tools
    p7zip
    unrar
    wl-clipboard
  ];
}
