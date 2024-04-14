{ pkgs, ... }: {
  home.packages = with pkgs; [
    ripgrep
    fzf
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    colorschemes.gruvbox = {
      enable = true;
      settings.bold = true;
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

      airline.enable = true;

      coq-nvim = {
        enable = true;
        settings.auto_start = true;
        settings.keymap.recommended = true;
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
