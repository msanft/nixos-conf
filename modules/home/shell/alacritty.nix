{ ... }: {
  programs.alacritty =
    let
      font = "BerkeleyMono Nerd Font Mono";
    in
    {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 0;
            y = 0;
          };
          dynamic_padding = true;
          decorations = "none";
        };
        selection.save_to_clipboard = true;
        font = {
          normal = {
            family = font;
            style = "Regular";
          };
          bold = {
            family = font;
            style = "Bold";
          };
          italic = {
            family = font;
            style = "Italic";
          };
          size = 11;
        };
      };
    };
}
