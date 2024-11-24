{ config, ... }:
{
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  home-manager.users.msanft.imports = [
    ./home.nix
  ];
}
