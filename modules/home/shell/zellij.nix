{ ... }: {
  programs.zellij = {
    enable = true;
    settings = {
      theme = "gruvbox-dark";
      themes.gruvbox-dark = {
        fg = "#ebdbb2";
        bg = "#282828";
        black = "#282828";
        red = "#cc241d";
        green = "#98971a";
        yellow = "#d79921";
        blue = "#458588";
        magenta = "#b16286";
        cyan = "#689d6a";
        white = "#a89984";
        orange = "#d65d0e";
      };
      ui.pane_frames.hide_session_name = true;
      default_layout = "compact";
      on_force_close = "quit";
      mouse_mode = false;
    };
  };

  programs.zsh.initExtra = ''
    if [[ -z "$ZELLIJ" && "$TERM_PROGRAM" != "vscode" ]]; then
      if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
          zellij attach -c
      else
          zellij
      fi

      if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
          exit
      fi
    fi
  '';
}
