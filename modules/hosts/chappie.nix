{ inputs, self, config, ... }:
let
  inherit (self) outputs;
in
{
  flake.nixosConfigurations.chappie = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [ config.flake.modules.nixos.chappie ];
  };

  flake.modules.nixos.chappie = {
    imports = [
      ../../hosts/chappie
      inputs.disko.nixosModules.disko
      inputs.preservation.nixosModules.preservation
    ];
  };
}
