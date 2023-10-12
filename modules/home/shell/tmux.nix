{ config, ... }: {
  programs.tmux = {
    enable = true;
    mouse = true;
    terminal = "alacritty";
  };
}
