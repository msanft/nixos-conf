{ pkgs, ... }:
let
  fontList = import ../../common/fonts.nix { pkgs = pkgs; };
in
{
  fonts = {
    enableDefaultFonts = true;
    fonts = fontList;

    fontconfig = {
      defaultFonts = {
        serif = [ "Roboto" ];
        sansSerif = [ "Roboto" ];
        monospace = [ "JetBrains Mono" ];
      };
    };
  };
}
