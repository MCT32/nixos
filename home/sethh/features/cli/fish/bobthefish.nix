{ pkgs, ... }: {
  programs.fish = {
    plugins = [
      {
        name = "bobthefish";
        src = pkgs.fishPlugins.bobthefish.src;
      }
    ];

    interactiveShellInit = ''
      set -g theme_color_scheme gruvbox
    '';
  };
}
