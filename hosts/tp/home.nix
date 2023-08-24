{ pkgs, ... }: {
  imports = [
    ../common/home.nix
    ../../modules/home/chromium
    ../../modules/home/neovim
    ../../modules/home/gpg
    ../../modules/home/wm
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
