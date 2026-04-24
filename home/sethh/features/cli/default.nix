{
  pkgs,
  ...
}: {
  imports = [
    ./fish

    ./bat.nix
    ./btop.nix
    ./vim.nix
  ];

  home.packages = with pkgs; [
    ncdu # Disk usage TUI
    tree
  ];
}
