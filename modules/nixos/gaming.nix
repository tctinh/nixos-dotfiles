{ pkgs, username, ... }: {
  # Steam and runtime support
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Steam Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
  };

  # Game performance tooling
  programs.gamemode = {
    enable = true; # Feral Interactive optimizations. Use Steam launch option: gamemoderun %command%
    settings = { };
  };

  programs.gamescope.enable = true;

  # Decky plugin loader (Jovian)
  jovian.decky-loader = {
    enable = true;
    user = username;
  };

  # Enable 32-bit graphics support (required for Steam)
  # Note: On NixOS 24.05 and newer, use 'hardware.graphics'.
  # On older versions, use 'hardware.opengl'.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    (lutris.override {
      extraPkgs = _: [
        # List package dependencies here
      ];
    })
  ];
}
