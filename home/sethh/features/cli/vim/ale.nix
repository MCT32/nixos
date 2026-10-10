{ pkgs, ... }:
{
  programs.vim = {
    plugins = with pkgs.vimPlugins; [ ale ];

    extraConfig = ''
      let g:ale_completion_enabled = 1

      let g:ale_linters = {
      \  'nix': ['statix'],
      \  'php': ['php', 'intelephense'],
      \  'rust': ['analyzer'],
      \  'svelte': ['svelteserver'],
      \}

      let g:ale_fixers = {
      \  '*': ['remove_trailing_lines', 'trim_whitespace'],
      \  'nix': ['nixfmt'],
      \  'rust': ['rustfmt'],
      \  'svelte': ['prettier'],
      \}
      let g:ale_fix_on_save = 1

      let g:ale_rust_analyzer_config = {
      \  'check': { 'command': 'clippy' },
      \}

      set omnifunc=ale#completion#OmniFunc
      set completeopt=menu,menuone,popup,noselect,noinsert

      nmap <silent> [g <Plug>(ale_previous_wrap)
      nmap <silent> ]g <Plug>(ale_next_wrap)
      nmap <silent> gd :ALEGoToDefinition<CR>
      nmap <silent> gr :ALEFindReferences<CR>
      nmap <silent> K  :ALEHover<CR>
      nmap <leader>f  <Plug>(ale_fix)
    '';
  };

  home.packages = with pkgs; [
    # PHP
    intelephense

    # Nix
    nixfmt
    statix

    # Svelte
    svelte-language-server
    prettier
  ];
}
