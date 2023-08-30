{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs; [
    vimPlugins.vim-airline
  {
    plugin = vimPlugins.vim-airline-themes;
    config = "let g:airline_theme='base16_gruvbox_dark_hard'";
  }
  ];
}
