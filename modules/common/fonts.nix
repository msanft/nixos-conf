{ pkgs, inputs, ... }:
let
  berkeley-mono = inputs.berkeley-mono.packages.x86_64-linux;
in
with pkgs; [
  roboto
  noto-fonts
  jetbrains-mono
  font-awesome # For waybar icons
  (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  berkeley-mono.berkeley-mono
  berkeley-mono.berkeley-mono-nerd-font
]
