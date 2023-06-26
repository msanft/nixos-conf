{ config, pkgs, lib, ... }: {
  imports = [
    ../common
    ./desktop
    ./gpg.nix
    ./wm
  ];

  programs.vscode.enable = true;

  home.packages = with pkgs; [
    file
    docker
    sage
    apfs-fuse
    ghidra
    gdb
    gef
    pwndbg
  ];
}
