{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs; [
    vimPlugins.nvim-tree-lua
  ];
}
