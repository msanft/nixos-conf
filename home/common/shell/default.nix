{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./zsh.nix
    ./tmux.nix
    ./starship.nix
  ];
}
