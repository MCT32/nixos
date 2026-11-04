{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = [
    inputs.tagstudio.packages.${pkgs.stdenv.hostPlatform.system}.tagstudio
  ];
}
