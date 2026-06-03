{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    blender
    fspy
  ];
}
