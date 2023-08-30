{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox = {
      enable = true;
    };
    plugins = {
      comment-nvim.enable = true;
      emmet.enable = true;
      nvim-autopairs.enable = true;
      bufferline.enable = true;
      fugitive.enable = true;
      gitgutter.enable = true;
      gitsigns.enable = true;

      airline = {
        enable = true;
        theme = "base16_gruvbox_dark_soft";
      };

      coq-nvim = {
        enable = true;
        autoStart = "shut-up";
        installArtifacts = true;
        recommendedKeymaps = true;
      };

      lsp = {
        enable = true;
        servers = {
          gopls.enable = true;
        };
      };
    };
  };
}
