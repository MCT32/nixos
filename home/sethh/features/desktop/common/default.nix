{
  pkgs,
  ...
}: {
  imports = [
    ./qutebrowser.nix
  ];

  home.packages = with pkgs; [
    tidal-hifi
  ];
}
