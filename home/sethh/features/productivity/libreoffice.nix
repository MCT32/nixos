{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # TODO: Look into different package variants
    libreoffice-qt-fresh
    hunspell
    hunspellDicts.en-au # Australian english
    hunspellDicts.de-de # German
    # TODO: Make toki pona work in libreoffice
    hunspellDicts.tok   # toki pona
  ];
}
