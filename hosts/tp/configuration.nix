{ pkgs, ... }: {
  imports = [
    ../../modules/services/desktop
    ../../modules/services/greetd
    ../../modules/services/input
    ../../modules/services/vt-color
    ../../modules/system/boot
    ../../modules/system/fonts
    ../../modules/system/i18n
    ../../modules/system/networking
    ../../modules/system/security
    ../../modules/system/virt
    ../../modules/system/xdg
    ../../modules/system/audio
    ../common
    ./hardware-configuration.nix
  ];

  users.users.moritzs = {
    isNormalUser = true;
    description = "Moritz Sanft";
    extraGroups = [ "networkmanager" "wheel" "docker" "audio" ];
    shell = pkgs.zsh;
  };

  home-manager.users.moritzs = { pkgs, ... }: {
    home.stateVersion = "22.11";
    imports = [
      ../../home/tp
    ];
  };

  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
    };
    stateVersion = "22.11";
  };
}
