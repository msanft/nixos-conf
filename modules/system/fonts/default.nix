{ pkgs, inputs, ... }:
let
  berkeley-mono = inputs.berkeley-mono.packages.x86_64-linux;
  fontList = with pkgs; [
    roboto
    noto-fonts
    jetbrains-mono
    font-awesome # For waybar icons
    nerd-fonts.jetbrains-mono
    berkeley-mono.berkeley-mono
    berkeley-mono.berkeley-mono-nerd-font
  ];
in
{
  fonts = {
    enableDefaultPackages = true;
    packages = fontList;

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "TX-02 Condensed" ];
      };

      subpixel.rgba = "rgb";
    };
  };
}
