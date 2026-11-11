{
  lib,
  inputs,
  config,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.age.keyFile = lib.mkDefault "/home/sethh/.config/sops/age/keys.txt";
}
