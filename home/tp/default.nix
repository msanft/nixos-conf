{ pkgs, ... }: {
  imports = [
    ../common
    ./desktop
    ./gpg.nix
    ./ghidra.nix
    ./wm
  ];

  programs.vscode.enable = true;

  home.packages = with pkgs; [
    file
    docker
    sage
    apfs-fuse
    gdb
    gef
    pwndbg
    nasm
    bluetuith
    pavucontrol
  ];
}
