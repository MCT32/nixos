{
  inputs,
  ...
}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;

    discord = {
      vencord.enable = false;
      equicord.enable = true;
      krisp.enable = true;
    };

    config = {
      # TODO: Add more plugins
      plugins = {
        fakeNitro.enable = true;
      };
    };
  };
}
