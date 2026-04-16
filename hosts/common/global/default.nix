# Configs for all hosts
{
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    ./locale.nix
    ./sops.nix
    ./tailscale.nix
  ]
  ++ (builtins.attrValues outputs.nixosModules);

  # Home manager global stuff
  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
