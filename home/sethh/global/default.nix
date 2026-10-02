{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}:
{
  imports = [
    ../features/cli
  ]
  ++ (builtins.attrValues outputs.homeManagerModules);

  home.username = "sethh";
  home.homeDirectory = "/home/sethh";

  sops.age.keyFile = "/home/sethh/.config/sops/age/keys.txt";

  home.packages = with pkgs; [
    brightnessctl # TODO: Move to machine specific config
  ];

  # TODO: Move
  programs.rofi = {
    enable = true;
  };

  # TODO: Move
  programs.kitty = {
    enable = true;

    shellIntegration.enableFishIntegration = true;
  };

  home.stateVersion = "25.11";
}
