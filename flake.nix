{
  description = "NixOS + Home Manager configuration with plasma-manager for KDE";

  inputs = {
    # Stable NixOS channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    # Unstable channel for bleeding-edge packages (gemini-cli, etc.)
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # VS Code Insiders - tracks latest nightly releases
    vscode-insiders = {
      url = "github:auguwu/vscode-insiders-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # opencode uses its own nixpkgs (unstable) to avoid compatibility issues
    opencode = {
      url = "github:anomalyco/opencode?ref=dev";
      # Don't follow nixpkgs - let it use its own
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, plasma-manager, vscode-insiders, opencode, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { 
        inherit system;
        config.allowUnfree = true;
        overlays = [ (import vscode-insiders) ];
      };

      # Unstable pkgs for bleeding-edge packages
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
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
            # Apply vscode-insiders overlay
            nixpkgs.overlays = [ (import vscode-insiders) ];
            
            environment.systemPackages = lib.mkAfter [
              # From flake inputs
              opencode.packages.${system}.default
              pkgs.vscode-insiders

              # Packages from unstable channel
              pkgs-unstable.vscode.fhs
              pkgs-unstable.gemini-cli
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
