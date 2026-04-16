{ pkgs, ... }:

{
  imports = [
    ./gaming/steam.nix
    ./gaming/alvr.nix
  ];
}
