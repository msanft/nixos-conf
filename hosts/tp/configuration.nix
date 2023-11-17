{  pkgs, inputs, ... }: {
  imports = [
    ../../modules/services/desktop
    ../../modules/services/greetd
    ../../modules/services/input
    ../../modules/services/vt-color
    ../../modules/system/i18n
    ../../modules/system/networking
    ../../modules/system/security
    ../../modules/system/virt
    ../../modules/system/xdg
    ../../modules/system/audio
    ../../modules/system/kernel
    ../../modules/system/fonts
    ../common
  ];

  users.users.moritzs = {
    isNormalUser = true;
    description = "Moritz Sanft";
    extraGroups = [ "networkmanager" "wheel" "docker" "audio" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  home-manager.users.moritzs = { pkgs, ... }: {
    home.stateVersion = "22.11";
    imports = [
      ./home.nix
    ];
  };

  system = {
    stateVersion = "22.11";
  };
}
