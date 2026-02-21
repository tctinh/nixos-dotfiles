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

    jovian = {
      url = "git+https://github.com/Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
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

    catppuccin.url = "github:catppuccin/nix";

    # Chaotic-Nyx removed (archived)
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, opencode, vscode-insiders, catppuccin, jovian, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs { 
        inherit system;
        config.allowUnfree = true;
        overlays = [ (import vscode-insiders) ];
      };

      # Custom packages
      hexcore-link = pkgs.callPackage ./pkgs/hexcore-link { };
      hexcore-link-udev-rules = pkgs.callPackage ./pkgs/hexcore-link/udev-rules.nix { };

      # Wrap Caprine to use X11 for Vietnamese input support
      inherit (pkgs.callPackage ./pkgs/caprine-x11 { }) caprine-x11 caprine-x11-desktop;

      # Wrap vscode-insiders with FHS for extension support
      inherit (pkgs.callPackage ./pkgs/vscode-insiders-fhs { }) vscode-insiders-fhs vscode-insiders-desktop;

      # User configuration
      username = "tctinh";
      hostname = "nixos";
    in
    {
      # NixOS system configuration
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit pkgs;
        specialArgs = {
          inherit username hostname;
        };
        modules = [
          ./hosts/${hostname}/configuration.nix

          catppuccin.nixosModules.catppuccin
          jovian.nixosModules.default

          # Include Home Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                inherit username hostname;
              };

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
              # Custom packages
              hexcore-link
              caprine-x11
              caprine-x11-desktop
            ];
            
            # Udev rules for Hexcore keyboards
            services.udev.packages = [ hexcore-link-udev-rules ];
          })
        ];
      };

      # Standalone home-manager configuration (for systems without NixOS)
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit username hostname;
        };
        modules = [
          plasma-manager.homeModules.plasma-manager
          ./home/${username}.nix
        ];
      };

      # Development shells
      devShells.${system} =
        let
          mkPythonShell = python: pythonPackages: pkgs.mkShell {
            buildInputs = [
              python
              pkgs.uv
              pythonPackages.pip
              pythonPackages.setuptools
              pythonPackages.wheel
            ];
          };
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nil # Nix LSP
              nixfmt-rfc-style
            ];
          };

          py312 = mkPythonShell pkgs.python312 pkgs.python312Packages;
          py313 = mkPythonShell pkgs.python313 pkgs.python313Packages;
          py314 = mkPythonShell pkgs.python314 pkgs.python314Packages;
          py315 = mkPythonShell pkgs.python315 pkgs.python315Packages;
        };
    };
}
