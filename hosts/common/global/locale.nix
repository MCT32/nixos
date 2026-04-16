{ lib, ... }: {
  i18n = {
    defaultLocale = lib.mkDefault "en_AU.UTF-8";

    supportedLocales = lib.mkDefault [
      "en_AU.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"  # German
    ];
  };

  time.timeZone = "Australia/Melbourne";
}
