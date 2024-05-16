{ pkgs, ... }: {
  imports = [
    ../common/home.nix
    ../../modules/home/browser/firefox
    ../../modules/home/browser/chromium
    ../../modules/home/nixvim.nix
    ../../modules/home/thunderbird.nix
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
    ranger
    cinny-desktop
    obsidian
    unzip
    zip
    gnupg
    pass
  ];

  my.thunderbird.enable = true;
}
