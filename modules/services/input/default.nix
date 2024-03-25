{ pkgs, ... }: {
  services.xserver = {
    xkb = {
      layout = "us-custom,de-custom";
      options = "ctrl:nocaps,grp:win_space_toggle";
      extraLayouts = {
        us-custom = {
          description = "US (ANSI) custom layout";
          languages = [ "eng" ];
          symbolsFile = pkgs.copyPathToStore ./symbols/us-custom;
        };
        de-custom = {
          description = "DE (ISO) custom layout";
          languages = [ "ger" ];
          symbolsFile = pkgs.copyPathToStore ./symbols/de-custom;
        };
      };
    };

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "adaptive";
      };
    };
  };

  console.useXkbConfig = true;
}
