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

    # Development
    bun
    ghostty

    # System utilities
    lenovo-legion
    noisetorch
  ];
}
