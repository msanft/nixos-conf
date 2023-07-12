{ pkgs, ... }: {
  gtk = {
    enable = true;
  };

  home.packages = [ pkgs.dconf ];
}
