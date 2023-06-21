{ pkgs, ... }: {
  # Required to store VS Code auth tokens.
  services.gnome.gnome-keyring.enable = true;

  services.dbus.enable = true;
}
