{ pkgs, ... }: {
  programs.neovim.extraPackages = with pkgs; [
    ripgrep
    fd
  ];
  programs.neovim.plugins = with pkgs; [
    {
      plugin = vimPlugins.telescope-nvim;
      config = ''
        vim.keymap.set('n', 'ff', '<cmd>Telescope find_files<cr>', { noremap = true })
      '';
      type = "lua";
    }
  ];
}
