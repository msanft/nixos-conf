{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./zsh.nix
    ./tmux.nix
  ];
}
