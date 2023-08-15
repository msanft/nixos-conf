{ lib, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      selection.save_to_clipboard = true;
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        font = lib.mkIf pkgs.stdenv.isDarwin
          {
            normal = {
              family = "JetBrainsMono Nerd Font";
              style = "Regular";
            };
            bold = {
              family = "JetBrainsMono Nerd Font";
              style = "Bold";
            };
          };
      };
    };
  };
}
