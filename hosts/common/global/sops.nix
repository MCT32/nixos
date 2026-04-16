{
  inputs,
  config,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops.age.keyFile = "/home/sethh/.config/sops/age/keys.txt";
}
