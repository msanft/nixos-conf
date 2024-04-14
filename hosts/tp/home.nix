{ pkgs, ... }: {
  imports = [
    ../common/home.nix
    ../../modules/home/browser/firefox
    ../../modules/home/browser/chromium
    ../../modules/home/gpg
    ../../modules/home/wm
    ../../modules/home/nixvim
  ];

  home.packages = with pkgs; [
    file
    docker
    bluetuith
    pavucontrol
    wireguard-tools
    zathura
    slack
    man-pages
    man-pages-posix
    brightnessctl
    gdb
    clang-tools_17
    gcc13
    linuxHeaders
    gomuks
    mutt
    ranger
    cinny-desktop
    obsidian
  ];
}
