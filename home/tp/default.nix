{ config, pkgs, lib, ... }: {
  imports = [
    ../common
    ./desktop
    ./wm
  ];

  programs.vscode.enable = true;
  home.packages = with pkgs; [
    file
    docker
  ];
}
