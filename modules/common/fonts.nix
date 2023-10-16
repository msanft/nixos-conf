{ pkgs }: with pkgs; [
  roboto
  noto-fonts
  jetbrains-mono
  font-awesome # For waybar icons
  (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
]
