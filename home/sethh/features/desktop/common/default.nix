{
  pkgs,
  ...
}: {
  imports = [
    ./discord.nix
    ./qutebrowser.nix
  ];

  home.packages = with pkgs; [
    tidal-hifi
  ];
}
