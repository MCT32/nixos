{
  pkgs,
  ...
}: {
  imports = [
    ./vim.nix
  ];

  home.packages = with pkgs; [
    ncdu # Disk usage TUI
  ];
}
