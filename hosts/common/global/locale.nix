{
  lib,
  pkgs,
  ...
}: {
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        (pkgs.stdenv.mkDerivation {
          pname = "ilo-sitelen";
          version = "unstable-2023";

          src = pkgs.fetchFromGitHub {
            owner = "0x182d4454fb211940";
            repo = "ilo-sitelen";
            rev = "master";
            sha256 = "sha256-caQVPBPuZjOwbtcDhxAdmG7PHXe50OeSLkSBoCtMcrQ="; # Replace with actual hash if mismatched
          };

          nativeBuildInputs = with pkgs; [ cmake pkg-config ];
          buildInputs = with pkgs; [ fcitx5 ];

          cmakeFlags = [
            "-DCMAKE_BUILD_TYPE=Release"
          ];
        })
      ];

      fcitx5.waylandFrontend = true;
    };

    # TODO: Maker german default, for learning
    defaultLocale = lib.mkDefault "en_AU.UTF-8";

    supportedLocales = lib.mkDefault [
      "en_AU.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"  # German
    ];
  };

  time.timeZone = "Australia/Melbourne";
}
