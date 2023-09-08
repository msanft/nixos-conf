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
        serif = [ "Roboto" ];
        sansSerif = [ "Roboto" ];
        monospace = [ "JetBrains Mono" ];
      };
    };
  };
}
