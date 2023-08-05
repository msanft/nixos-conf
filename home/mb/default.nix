{ pkgs, ... }: {
  imports = [
    ../common
  ];

  home.packages = with pkgs; [
    teams
    slack
    discord
    zoom-us
  ];
}
