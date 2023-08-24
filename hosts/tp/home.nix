{ pkgs, ... }: {
  imports = [
    ../common/home.nix
    ../../home/modules/chromium
    ../../home/modules/neovim
    ../../home/modules/gpg
    ../../home/modules/wm
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
