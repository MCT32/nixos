{
  pkgs,
  ...
}: {
  # TODO: Make these not common
  imports = [
    ./discord.nix
    ./qutebrowser.nix
  ];

  # TODO: Make this not common
  home.packages = with pkgs; [
    tidal-hifi
  ];
}
