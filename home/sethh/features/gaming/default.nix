{
  pkgs,
  ...
}: {
  imports = [
    ./retroarch
  ];

  home.packages = with pkgs; [
    prismlauncher
    wheelwizard
    dolphin-emu
  ];
}
