{ pkgs, ... }: {
  imports = [
    ../common
    ./gpg.nix
    ../modules/chromium
    ../modules/neovim
    ../modules/gpg
    ../modules/desktop
    ../modules/wm
  ];

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
    slack
    teams
    discord
  ];
}
