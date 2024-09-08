{ pkgs, ... }:
{
  imports = [
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
    ../../modules/nixos/i3
    ../common
  ];

  networking.hostName = "tp";

  users.users.moritzs = {
    isNormalUser = true;
    description = "Moritz Sanft";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "audio"
    ];
    shell = pkgs.bash;
  };

  home-manager.users.moritzs =
    { ... }:
    {
      home.stateVersion = "22.11";
      imports = [ ./home.nix ];
    };

  services.fwupd.enable = true;

  my = {
    services.tailscale.enable = true;
    yubikey.enable = true;
    secureboot.enable = true;
    i3.enable = true;
  };

  system.stateVersion = "22.11";
}
