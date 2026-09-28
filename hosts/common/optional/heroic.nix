{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (heroic.override {
      extraPkgs = pkgs': with pkgs'; [
        gamescope
        gamemode
      ];
    })
  ];

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
}
