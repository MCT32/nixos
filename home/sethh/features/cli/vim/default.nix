{
  pkgs,
  ...
}:
{
  imports = [
    ./ale.nix
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-commentary
      vim-svelte
      vim-teal
    ];

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
