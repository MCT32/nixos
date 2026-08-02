{
  pkgs,
  ...
}: {
  imports = [
    ./fish

    ./bat.nix
    ./btop.nix
    ./git.nix
    ./vim.nix
  ];

  home.packages = with pkgs; [
    cava # Music visualiser
    fastfetch
    ncdu # Disk usage TUI
    tree
    unzip
  ];
}
