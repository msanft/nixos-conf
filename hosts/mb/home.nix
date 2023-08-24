{ pkgs, ... }: {
  imports = [
    ../common/home.nix
  ];

  home.packages = with pkgs; [
    teams
    slack
    discord
    zoom-us
  ];
}
