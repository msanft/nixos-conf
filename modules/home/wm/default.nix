{ pkgs, ... }: {
  imports = [
    ./sway.nix
    ./rofi.nix
    ./kanshi.nix
    ./waybar.nix
    ./swaylock.nix
    ./swayidle.nix
    ./gtk.nix
    ./mako.nix
  ];

  home.packages = with pkgs; [
    swayimg
    xdg-utils
    xwayland
    kanshi
    grim
    slurp
    wl-clipboard
  ];
  programs.zellij.settings.copy_command = "wl-copy";

  home.pointerCursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    gtk.enable = true;
    x11.enable = true;
  };

}
