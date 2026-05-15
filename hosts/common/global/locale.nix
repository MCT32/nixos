{ lib, ... }: {
  i18n = {
    # TODO: Maker german default, for learning
    defaultLocale = lib.mkDefault "en_AU.UTF-8";

    supportedLocales = lib.mkDefault [
      "en_AU.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"  # German
    ];
  };

  time.timeZone = "Australia/Melbourne";
}
