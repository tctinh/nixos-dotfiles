{
  description = "NixOS + Home Manager configuration with plasma-manager for KDE";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    compose2nix = {
      url = "github:aksiksi/compose2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    opencode = {
      url = "github:anomalyco/opencode?ref=dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, compose2nix, opencode, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

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
          ({ lib, ... }: {
            environment.systemPackages = lib.mkAfter [
              compose2nix.packages.${system}.default
              opencode.packages.${system}.default
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
