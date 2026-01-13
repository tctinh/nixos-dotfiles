{ pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Core tools
    vim
    wget
    git
    gh
    nodejs
    jq
    fastfetch
    htop
    lshw
    lm_sensors

    # Btrfs tools
    btrfs-progs
    kdePackages.partitionmanager

    # Office
    libreoffice-qt-fresh

    # Development
    bun

    # System utilities
    lenovo-legion
    noisetorch

    # Database tools
    mongodb-compass
  ];
}
