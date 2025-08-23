{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.gnome;
in
{
  options.my.gnome = with lib; {
    enable = mkEnableOption "Enable Gnome DE.";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    programs.dconf.enable = true;

    environment.gnome.excludePackages = with pkgs; [
      baobab
      epiphany
      evince
      file-roller
      geary
      gnome-backgrounds
      gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-connections
      gnome-console
      gnome-contacts
      gnome-disk-utility
      gnome-logs
      gnome-maps
      gnome-music
      gnome-software
      gnome-text-editor
      gnome-tour
      gnome-user-docs
      gnome-weather
      orca
      simple-scan
      snapshot
      totem
      xterm
      yelp
    ];
  };
}
