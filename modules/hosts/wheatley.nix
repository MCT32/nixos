{ inputs, self, config, ... }:
let
  inherit (self) outputs;
in
{
  flake.nixosConfigurations.wheatley = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [ config.flake.modules.nixos.wheatley ];
  };

  flake.modules.nixos.wheatley = {
    imports = [
      ../../hosts/wheatley
      inputs.disko.nixosModules.disko
      inputs.preservation.nixosModules.preservation
    ];
  };
}
