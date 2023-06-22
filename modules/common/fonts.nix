{ pkgs }:
with pkgs; [
  roboto
  jetbrains-mono
  font-awesome # For waybar icons
  (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
]
