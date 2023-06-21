{ pkgs, ... }: {
  services.xserver.libinput = {
    enable = true;
    mouse = {
      accelProfile = "adaptive";
    };
  };
}
