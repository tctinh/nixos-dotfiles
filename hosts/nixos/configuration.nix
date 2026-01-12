# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Add /etc/hosts-style static host entries so internal domains resolve locally
  networking.extraHosts = ''
    20.15.80.95 attu-dev.cadence-ai.com milvus-dev.cadence-ai.com langfuse-dev.cadence-ai.com rag-dev.cadence-ai.com mongo-express-dev.cadence-ai.com flower.cadence-ai.com
    20.3.22.249 attu-preprod.cadence-ai.com mongo-express.cadence-ai.com flower-preprod.cadence-ai.com
  '';

  # Enable networking
  networking.networkmanager.enable = true;

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/8429a579-0542-4984-a3b4-9d441fdea12f";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" "noatime" ];
    };

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tctinh = {
    isNormalUser = true;
    description = "tctinh";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.bash;
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;	
  # Install firefox.
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.zsh.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  
  # Session environment variables so GTK/Qt/Wayland sessions use fcitx5.
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    IM_CONFIG_PHASE = "1";
  };

  # Configure fcitx5 via the NixOS inputMethod option.
  # This ensures the patched `fcitx5-with-addons` binary and addons
  # are used (avoids addon-detection problems when installing via
  # `environment.systemPackages`). It also enables the Wayland frontend.
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-bamboo
        # KDE/Qt integration
        kdePackages.fcitx5-qt
        kdePackages.fcitx5-configtool
      ];
    };
  };

  # Also set IM environment variables globally so display manager/session
  # processes (SDDM / Plasma) definitely inherit them.
  environment.variables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim
     wget
     git
     gh
     nodejs
     jq
     fastfetch
     htop
     lshw

     btrfs-progs
     kdePackages.partitionmanager

     gemini-cli

     vscode.fhs
     microsoft-edge
     teams-for-linux
     libreoffice-qt-fresh
     
     discord
     steam
     (lutris.override {
        extraLibraries =  pkgs: [
          # List library dependencies here
        ];
      })    
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  # Kernel / OpenGL / NVIDIA (hybrid laptop)
  hardware.graphics.enable = true;

  hardware.nvidia.powerManagement.finegrained = true;

  # Video drivers: include your integrated GPU driver and "nvidia".
  # Replace "intel" with "amdgpu" if you have an AMD iGPU.
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  # Enable NVIDIA modesetting (recommended for Wayland sessions)
  hardware.nvidia.modesetting.enable = true;

  # Use the open-source NVIDIA kernel modules (required for driver versions >= 560,
  # recommended for Turing and later GPUs like the RTX 4060).
  hardware.nvidia.open = true;

  # Keep a Mesa package available for mixed-driver workflows
  hardware.graphics.extraPackages = with pkgs; [ mesa ];

  hardware.nvidia.prime = {
    	offload = {
    	  enable = true;
      	enableOffloadCmd = true;
    	};

	# Make sure to use the correct Bus ID values for your system!
	amdgpuBusId = "PCI:06:00:0";
	nvidiaBusId = "PCI:01:00:0";
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.waydroid.enable = true;
}
