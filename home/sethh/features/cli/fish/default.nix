{
  imports = [
    ./bobthefish.nix
    ./zoxide.nix
  ];

  programs.fish = {
    enable = true;
  };
}
