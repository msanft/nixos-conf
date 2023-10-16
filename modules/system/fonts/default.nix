{ pkgs, ... }:
let
  fontList = import ../../common/fonts.nix { pkgs = pkgs; };
in
{
  fonts = {
    enableDefaultPackages = true;
    packages = fontList;

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "JetBrains Mono" ];
      };
    };
  };
}
