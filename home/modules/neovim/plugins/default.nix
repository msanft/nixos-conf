{ pkgs, ... }: {
  programs.neovim.plugins =
    import ./airline pkgs ++
    import ./treesitter pkgs;
}
