{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.pointerCursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    gtk.enable = true;
    x11.enable = true;
    size = 24;
  };

  gtk = {
    enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = false;
    };
  };
}
