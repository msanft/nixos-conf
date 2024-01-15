{ pkgs, ... }: {
  home.packages = with pkgs; [
    ripgrep
    fzf
  ];

  programs.nixvim = {
    enable = true;

    options = {
      number = true;
      shiftwidth = 2;
    };

    colorschemes.gruvbox = {
      enable = true;
      bold = true;
    };

    clipboard.providers.wl-copy.enable = true;

    plugins = {
      treesitter.enable = true;

      lsp = {
        enable = true;
        servers = {
          gopls.enable = true;
        };
      };

      telescope = {
        enable = true;
        highlightTheme = "gruvbox";
        extensions = {
          fzf-native.enable = true;
        };
      };

      airline = {
        enable = true;
        theme = "base16_gruvbox_dark_soft";
      };

      coq-nvim = {
        enable = true;
        autoStart = true;
        recommendedKeymaps = true;
      };

      # comment-nvim.enable = true;
      # emmet.enable = true;
      nvim-autopairs.enable = true;
      which-key.enable = true;
      # nix.enable = true;
      # fugitive.enable = true;
      # gitgutter.enable = true;
      # gitsigns.enable = true;
    };
  };
}
