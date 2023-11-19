{ pkgs, inputs, ... }:
let
  fontList = import ../../common/fonts.nix { inherit pkgs inputs; };
in
{
  fonts = {
    enableDefaultPackages = true;
    packages = fontList;

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "BerkeleyMono Nerd Font Mono" ];
      };
    };
  };
}
