{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ncdu # Disk usage TUI
  ];
}
