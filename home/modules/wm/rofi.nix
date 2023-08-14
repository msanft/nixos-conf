{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland; # wayland native replacement
    theme = "gruvbox-dark";
  };
}
