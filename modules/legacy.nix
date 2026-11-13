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
  };
}
