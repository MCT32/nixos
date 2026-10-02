{
  pkgs,
  ...
}:
{
  imports = [
    ./fish
    ./vim

    ./bat.nix
    ./btop.nix
    ./git.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    cava # Music visualiser
    fastfetch
    ncdu # Disk usage TUI
    tree
    unzip
  ];
}
