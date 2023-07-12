{ pkgs, ... }: {
  imports = [
    ./sway.nix
    ./rofi.nix
    ./kanshi.nix
    ./waybar.nix
    ./swaylock.nix
    ./gtk.nix
  ];

  home.packages = with pkgs; [
    # Sway
    xdg-utils
    xwayland
    kanshi
    grim
    slurp
    wl-clipboard
  ];

  home.pointerCursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    gtk.enable = true;
  };
}
