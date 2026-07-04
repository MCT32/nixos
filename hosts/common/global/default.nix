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

  users.mutableUsers = false;

  services.udisks2.enable = true;

  # Home manager global stuff
  home-manager.useGlobalPkgs = true;  # TODO: What about user packages?
  home-manager.extraSpecialArgs = {
    # TODO: What does this do
    inherit inputs outputs;
  };

  home-manager.sharedModules = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "fspy-1.0.3"
  ];

  # Enable ssh
  services.openssh.enable = true;

  # Cloudflare DNS
  # FIXME: This is not actually used
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  system.stateVersion = "25.11";
}
