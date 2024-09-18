{ config, ... }: {
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  home-manager.users.msanft.imports = [
      ./home.nix
    ];

    boot.kernelParams = [ "nvidia_drm.fbdev=1" ];
}
