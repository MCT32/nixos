{ inputs, self, ... }:
let
  inherit (self) outputs;
  inherit (inputs.nixpkgs.lib) nixosSystem;

  specialArgs = { inherit inputs outputs; };
in
{
  flake = {
    # Import all my modules
    nixosModules = import ../old_modules/nixos;
    homeManagerModules = import ../old_modules/home-manager;

    nixosConfigurations = {
      # Gaming PC
      sentinel = nixosSystem {
        modules = [ ../hosts/sentinel ];
        inherit specialArgs;
      };

      # Touchscreen HP laptop
      eve = nixosSystem {
        modules = [ ../hosts/eve ];
        inherit specialArgs;
      };

      # Framework 13 Pro
      chappie = nixosSystem {
        modules = [
          ../hosts/chappie
          inputs.disko.nixosModules.disko
          inputs.preservation.nixosModules.preservation
        ];
        inherit specialArgs;
      };

      # Server
      wheatley = nixosSystem {
        modules = [
          ../hosts/wheatley
          inputs.disko.nixosModules.disko
          inputs.preservation.nixosModules.preservation
        ];
        inherit specialArgs;
      };
    };
  };
}
