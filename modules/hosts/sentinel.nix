{ inputs, self, config, ... }:
let
  inherit (self) outputs;
in
{
  flake.nixosConfigurations.sentinel = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [ config.flake.modules.nixos.sentinel ];
  };

  flake.modules.nixos.sentinel = {
    imports = [ ../../hosts/sentinel ];
  };
}
