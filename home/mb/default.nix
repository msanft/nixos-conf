{ config, pkgs, lib, ... }: {
  imports = [
    ../common
  ];

  home.packages = with pkgs; [
    teams
    slack
    discord
  ];
}
