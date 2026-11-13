{ inputs, self, config, ... }:
let
  inherit (self) outputs;
in
{
  flake.nixosConfigurations.eve = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [ config.flake.modules.nixos.eve ];
  };

  flake.modules.nixos.eve = {
    imports = [ ../../hosts/eve ];
  };
}
