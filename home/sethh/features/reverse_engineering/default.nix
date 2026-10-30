{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ghidra
    imhex
    scanmem
  ];
}
