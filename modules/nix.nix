{
  flake.modules.nixos.nix = {
    nix = {
      settings = {
        # TODO: Make common
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };
  };
}
