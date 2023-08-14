{ pkgs, ... }:
let
  theme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
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
    fonts = {
      serif = {
        package = pkgs.roboto;
        name = "Roboto";
      };

      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };

      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
        name = "JetBrains Mono";
      };

      emoji = {
        package = pkgs.font-awesome;
        name = "FontAwesome";
      };
    };
  };
}
