{ pkgs, ... }: {
  imports = [
    ./sway.nix
    ./rofi.nix
    ./kanshi.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    # Sway
    xdg-utils
    xwayland
    kanshi
  ];

  home.pointerCursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    gtk.enable = true;
  };
}
