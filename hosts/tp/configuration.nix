{ pkgs, inputs, modulesPath, ... }: {
  imports = [
    ../../modules/services/desktop
    ../../modules/services/greetd
    ../../modules/services/input
    ../../modules/services/tailscale
    ../../modules/system/i18n
    ../../modules/system/networking
    ../../modules/system/virt
    ../../modules/system/xdg
    ../../modules/system/audio
    ../../modules/system/kernel
    ../../modules/system/fonts
    ../../modules/nix/remote-builders.nix
    ../../modules/nixos/yubikey.nix
    ../../modules/nixos/secureboot.nix
    ../common
  ];

  networking.hostName = "tp";

  users.users.moritzs = {
    isNormalUser = true;
    description = "Moritz Sanft";
    extraGroups = [ "networkmanager" "wheel" "docker" "audio" "wireshark" ];
    shell = pkgs.bash;
  };

  home-manager.users.moritzs = { pkgs, ... }: {
    home.stateVersion = "22.11";
    imports = [
      ./home.nix
    ];
  };

  my.services.tailscale.enable = true;

  my.yubikey.enable = true;

  my.secureboot.enable = true;

  programs.wireshark.enable = true;
  environment.systemPackages = with pkgs; [ wireshark ];

  system.stateVersion = "22.11";
}
