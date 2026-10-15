{
  programs.librewolf = {
    enable = true;

    profiles = {
      default = {
        extensions.force = true;
      };
    };
  };

  stylix.targets.librewolf = {
    profileNames = [ "default" ];

    colorTheme.enable = true;
  };
}
