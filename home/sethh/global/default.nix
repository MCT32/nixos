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

  home = {
    username = "sethh";
    homeDirectory = "/home/sethh";

    packages = with pkgs; [
      brightnessctl # TODO: Move to machine specific config
    ];
  };

  sops.age.keyFile = "/home/sethh/.config/sops/age/keys.txt";

  # TODO: Move
  programs.rofi = {
    enable = true;
  };

  home.stateVersion = "25.11";
}
