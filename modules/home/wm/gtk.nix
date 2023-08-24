{ pkgs, ... }: {
  gtk = {
    enable = true;

    iconTheme = {
      name = "Arc";
      package = pkgs.arc-icon-theme;
    };
  };

  home.packages = [ pkgs.dconf ];
}
