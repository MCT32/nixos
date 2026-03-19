{ config, pkgs, ... }:

{
	imports = [
		./nixosModules/vim.nix
	];

	home.username = "root";
	home.homeDirectory = "/root";

	programs.bash.enable = true;

	home.stateVersion = "25.11";
}
