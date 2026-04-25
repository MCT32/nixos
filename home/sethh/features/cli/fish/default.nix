{
  imports = [
    ./tide.nix
    ./zoxide.nix
  ];

  programs.fish = {
    enable = true;
  };
}
