{
  inputs,
  ...
}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;

    discord.vencord.enable = false;
    discord.equicord.enable = true;

    config = {
      # TODO: Add more plugins
      plugins = {
        fakeNitro.enable = true;
      };
    };
  };
}
