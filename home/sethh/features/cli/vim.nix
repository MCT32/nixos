{
  pkgs,
  ...
}: {
  programs.vim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [ vim-airline ];

    settings = {
      number = true;
      relativenumber = true;

      tabstop = 4;
      shiftwidth = 4;
      expandtab = false;
    };

    extraConfig = ''
      set list
      set listchars=tab:>-,space:·
    '';
  };
}
