{ ... }:

{
  programs.vim = {
    enable = true;

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
