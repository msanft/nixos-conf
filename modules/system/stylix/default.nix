{ pkgs, ... }:
let
  theme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  wallpaper = pkgs.runCommand "image.png" { } ''
    COLOR=$(${pkgs.yq}/bin/yq -r .base00 ${theme})
    COLOR="#"$COLOR
    ${pkgs.imagemagick}/bin/magick convert -size 1920x1080 xc:$COLOR $out
  '';
in
{
  stylix = {
    image = wallpaper;
    base16Scheme = theme;
    fonts = rec {
      monospace = {
        name = "JetBrains Mono Nerd Font";
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      };
      serif = {
        name = "Roboto";
        package = pkgs.roboto;
      };
      sansSerif = {
        name = "Roboto";
        package = pkgs.roboto;
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };

      sizes = {
        terminal = 10;
        applications = 10;
        desktop = 10;
      };
    };
  };
}
