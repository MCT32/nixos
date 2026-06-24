{
  pkgs,
  ...
}: {
  # TODO: Make these not common
  imports = [
    ./discord.nix
    ./qutebrowser
  ];

  # TODO: Make this not common
  home.packages = with pkgs; [
    jetbrains.idea-oss
    tidal-hifi
  ];
}
