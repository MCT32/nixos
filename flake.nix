{
  description = "MCT32's NixOS flake";

  inputs = {
    # Nix packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Hardware configurations
    hardware.url = "github:nixos/nixos-hardware";

    # Home manager repo
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Sops for passwords
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix repo
    stylix = {
      url = "github:nix-community/stylix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixcord
    nixcord.url = "github:FlameFlag/nixcord";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Merge libs
    lib = nixpkgs.lib // home-manager.lib;

    # Configure packages for all systems
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
    in {
      inherit lib;

      # Import all my modules
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        # Gaming PC
        sentinel = lib.nixosSystem {
          modules = [./hosts/sentinel];
          specialArgs = {
            inherit inputs outputs;
          };
        };

        # Touchscreen HP laptop
        eve = lib.nixosSystem {
          modules = [./hosts/eve];
          specialArgs = {
            inherit inputs outputs;
          };
        };
      };
    };
}
