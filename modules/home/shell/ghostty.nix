{ ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      gtk-single-instance = true;
      theme = "GruvboxDarkHard";
      font-family = "BerkeleyMono Nerd Font Mono Condensed";
      command = "nu";
    };
  };
}
