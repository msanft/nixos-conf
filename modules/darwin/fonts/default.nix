{ pkgs, ... }:
let
  fontList = import ../../common/fonts.nix { pkgs = pkgs; };
in
{
  fonts = {
    fontDir.enable = true;
    fonts = fontList;
  };
}
