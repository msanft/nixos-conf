{ pkgs, ... }:
let
  fontList = with pkgs; [
    noto-fonts
    font-awesome # For waybar icons
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
  ];
in
{
  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    packages = fontList;

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Iosevka Nerd Font" ];
      };

      subpixel.rgba = "rgb";
    };
  };
}
