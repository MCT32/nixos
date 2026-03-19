{
	description = "NixOS laptop flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		stylix = {
			url = "github:nix-community/stylix/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, stylix, ... }@inputs:
		let
			system = "x86_64-linux";
		in {
			nixosConfigurations = {
				NixosLaptop = nixpkgs.lib.nixosSystem {
					specialArgs = { inherit inputs system; };
					modules = [
						./hosts/NixosLaptop/configuration.nix
						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.sethh = ./home.nix;
							home-manager.users.root = ./home-root.nix;
						}
						stylix.nixosModules.stylix
					];
				};
			};
		};
}
