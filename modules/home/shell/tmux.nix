{ config, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "alacritty";
    extraConfig = ''
      unbind - # unbind split pane
      unbind | # unbind split pane
      bind - split-window -v # split pane vertically
      bind | split-window -h # split pane horizontally
      bind > swap-pane -D # swap current pane with the next one
      bind < swap-pane -U # swap current pane with the previous one
      bind -r H resize-pane -L 2 # resize pane 2 cells to the left
      bind -r J resize-pane -D 2 # resize pane 2 cells down
      bind -r K resize-pane -U 2 # resize pane 2 cells up
      bind -r L resize-pane -R 2 # resize pane 2 cells to the right
    '';
  };
}
