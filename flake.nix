{
  description = "NixOS + Home Manager configuration with plasma-manager for KDE";

  inputs = {
    # Use unstable as the base for entire system (latest Plasma, etc.)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";  # master follows unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # opencode uses its own nixpkgs (unstable) to avoid compatibility issues
    opencode = {
      url = "github:anomalyco/opencode?ref=dev";
      # Don't follow nixpkgs - let it use its own
    };

    # VS Code Insiders - auto-updated hashes via GitHub Actions
    vscode-insiders = {
      url = "github:auguwu/vscode-insiders-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, opencode, vscode-insiders, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs { 
        inherit system;
        config.allowUnfree = true;
        overlays = [ (import vscode-insiders) ];
      };

      # Wrap vscode-insiders with FHS for extension support
      vscode-insiders-fhs = pkgs.buildFHSEnv {
        name = "code-insiders";
        targetPkgs = p: [
          pkgs.vscode-insiders
          # Required for extensions with native binaries
          p.stdenv.cc.cc.lib
          p.zlib
          p.openssl
          p.curl
          p.libsecret
          p.libkrb5
          p.icu
          # Network/auth for syncing
          p.glib
          p.nss
          p.nspr
          p.atk
          p.cups
          p.dbus
          p.expat
          p.libdrm
          p.libxkbcommon
          p.pango
          p.cairo
          p.mesa
          p.alsa-lib
          # Additional deps from wiki
          p.krb5
          p.libsoup_3
          p.webkitgtk_4_1
        ];
        runScript = "code-insiders";
        profile = ''
          export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
        '';
      };

      # Desktop entry for VS Code Insiders
      vscode-insiders-desktop = pkgs.makeDesktopItem {
        name = "code-insiders";
        desktopName = "Visual Studio Code - Insiders";
        comment = "Code Editing. Redefined.";
        exec = "${vscode-insiders-fhs}/bin/code-insiders %F";
        icon = "vscode-insiders";
        terminal = false;
        categories = [ "Utility" "TextEditor" "Development" "IDE" ];
        mimeTypes = [ "text/plain" "inode/directory" ];
        startupNotify = true;
        startupWMClass = "Code - Insiders";
      };

      # User configuration
      username = "tctinh";
      hostname = "nixos";
    in
    {
      # NixOS system configuration
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/${hostname}/configuration.nix

          # Include Home Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";

              # Add plasma-manager to home-manager
              sharedModules = [
                plasma-manager.homeModules.plasma-manager
              ];

              users.${username} = import ./home/${username}.nix;
            };
          }

          # Extra packages from flake inputs
          ({ lib, pkgs, ... }: {
            # Enable nix-ld for VSCode extensions with pre-compiled binaries
            programs.nix-ld.enable = true;
            
            environment.systemPackages = lib.mkAfter [
              # From flake inputs
              opencode.packages.${system}.default
              # VS Code FHS - stable version with extension support
              pkgs.vscode.fhs
              # VS Code Insiders - bleeding edge with extension support (FHS wrapped)
              vscode-insiders-fhs
              vscode-insiders-desktop
              pkgs.gemini-cli
            ];
          })
        ];
      };

      # Standalone home-manager configuration (for systems without NixOS)
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          plasma-manager.homeModules.plasma-manager
          ./home/${username}.nix
        ];
      };

      # Development shell
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nil  # Nix LSP
          nixfmt-rfc-style
        ];
      };
    };
}
