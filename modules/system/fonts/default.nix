{ pkgs, inputs, ... }:
let
  berkeley-mono = inputs.berkeley-mono.packages.x86_64-linux;
  fontList = with pkgs; [
    roboto
    noto-fonts
    jetbrains-mono
    font-awesome # For waybar icons
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
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
        monospace = [ "BerkeleyMono Nerd Font Mono" ];
      };

      subpixel.rgba = "rgb";
    };
  };
}
