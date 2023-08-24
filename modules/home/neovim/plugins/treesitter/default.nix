{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs; [
    vimPlugins.nvim-treesitter.withAllGrammars
  ];
}
