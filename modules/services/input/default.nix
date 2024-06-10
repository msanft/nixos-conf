{ pkgs, ... }: {
  services.xserver = {
    xkb = {
      layout = "us-custom,de-custom";
      options = "ctrl:nocaps,grp:win_space_toggle";
      extraLayouts = {
        us-custom = {
          description = "US (ANSI) custom layout";
          languages = [ "eng" ];
          symbolsFile = ./symbols/us-custom.xkb;
        };
        de-custom = {
          description = "DE (ISO) custom layout";
          languages = [ "ger" ];
          symbolsFile = ./symbols/de-custom.xkb;
        };
      };
    };
  };

  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "adaptive";
    };
  };

  console.useXkbConfig = true;
}
