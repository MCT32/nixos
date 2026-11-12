{
  lib,
  options,
  ...
}:
{
  config = lib.optionalAttrs (options ? preservation) {
    preservation = {
      preserveAt."/persist" = {
        users.sethh = {
          directories = [
            ".ssh"
            ".config/sops"
          ];
        };
      };
    };
  };
}
