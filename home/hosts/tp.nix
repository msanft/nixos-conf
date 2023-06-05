{config, pkgs, lib, ...}: {
  imports = [
    ./common.nix
    ../wm
  ];

  programs.vscode.enable = true;
}
