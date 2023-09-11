{ pkgs, ... }: {
  imports = [
    ../common/home.nix
    ../../modules/home/chromium
    ../../modules/home/gpg
    ../../modules/home/wm
    ../../modules/home/nixvim
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
    wireguard-tools
    zathura
    slack
  ];
}
