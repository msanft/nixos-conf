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

        colors = {
          primary = {
            background = "0x1d2021";
            foreground = "0xd5c4a1";
          };
          cursor = {
            text = "0x1d2021";
            cursor = "0xd5c4a1";
          };

          normal = {
            black = "0x1d2021";
            blue = "0x83a598";
            cyan = "0x8ec07c";
            green = "0xb8bb26";
            magenta = "0xd3869b";
            red = "0xfb4934";
            white = "0xd5c4a1";
            yellow = "0xfabd2f";
          };

          bright = {
            black = "0x665c54";
            blue = "0xbdae93";
            cyan = "0xd65d0e";
            green = "0x3c3836";
            magenta = "0xebdbb2";
            red = "0xfe8019";
            white = "0xfbf1c7";
            yellow = "0x504945";
          };

          indexed_colors = [
            { index = 16; color = "0xfe8019"; }
            { index = 17; color = "0xd65d0e"; }
            { index = 18; color = "0x3c3836"; }
            { index = 19; color = "0x504945"; }
            { index = 20; color = "0xbdae93"; }
            { index = 21; color = "0xebdbb2"; }
          ];
        };
      };
    };
}
