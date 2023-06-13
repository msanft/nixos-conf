{ config, pkgs, lib, ... }: {
  imports = [
    ../common
    ./desktop
    ./wm
  ];

  programs.vscode.enable = true;
  programs.alacritty.settings.font.normal.family = "JetBrains Mono";

  home.packages = with pkgs; [
    file
    docker
  ];
}
