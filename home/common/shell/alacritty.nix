{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      selection.save_to_clipboard = true;
      window = {
        padding = {
          x = 10;
          y = 10;
        };
      };
    };
  };
}
