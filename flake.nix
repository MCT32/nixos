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

    # Declaritive disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    preservation.url = "github:nix-community/preservation";

    # Stylix repo
    stylix = {
      url = "github:nix-community/stylix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixcord
    nixcord.url = "github:FlameFlag/nixcord";

    # Nix User Repository
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tagstudio = {
      url = "github:TagStudioDev/TagStudio";
      inputs.nixpkgs.follows = "nixpkgs"; # Use the same package set as your flake.
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; }
      (inputs.import-tree ./modules);
}
