{ pkgs, inputs, ... }: {
  imports = [
    ../../modules/services/desktop
    ../../modules/services/greetd
    ../../modules/services/input
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
    extraGroups = [ "networkmanager" "wheel" "docker" "audio" "wireshark" ];
    shell = pkgs.bash;
  };

  home-manager.users.moritzs = { pkgs, ... }: {
    home.stateVersion = "22.11";
    imports = [
      ./home.nix
    ];
  };

  programs.wireshark.enable = true;
  environment.systemPackages = with pkgs; [ wireshark ];

  system = {
    stateVersion = "22.11";
  };
}
