# Configs for all hosts
{
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    ./fish.nix
    ./locale.nix
    ./sops.nix
    ./stylix.nix
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

  # Cloudflare DNS
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];
}
