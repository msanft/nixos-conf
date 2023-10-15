{ config, ... }: {
  programs.tmux = {
    enable = true;
    
    terminal = "alacritty";
  };
}
