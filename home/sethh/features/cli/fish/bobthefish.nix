{ pkgs, ... }: {
  # TODO: Make tide config declaritive
  programs.fish = {
    plugins = [
      {
        name = "bobthefish";
        src = pkgs.fishPlugins.bobthefish.src;
      }
    ];
  };
}
