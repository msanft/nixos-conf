{ pkgs, ... }: {
  gtk = {
    enable = true;

    iconTheme = {
      name = "Arc";
      package = pkgs.arc-icon-theme;
    };

    theme = {
      name = "Arc";
      package = pkgs.arc-theme;
    };

    font = {
      name = "Roboto";
      package = pkgs.roboto;
    };
  };

  home.packages = [ pkgs.dconf ];
}
