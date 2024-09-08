{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.i3;
in
{
  options.my.i3 = with lib; {
    enable = mkEnableOption "Enable i3 WM.";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.moritzs.imports = [
      ./home.nix
    ];

    services.systemd-lock-handler.enable = true;

    services.dbus.enable = true;

    programs.dconf.enable = true;

    programs.i3lock = {
      enable = true;
      u2fSupport = true;
    };

    systemd.user.services.i3 = {
      description = "Screen locker for i3";
      documentation = [ "man:i3lock(1)" ];

      # If i3lock exits cleanly, unlock the session:
      onSuccess = [ "unlock.target" ];

      # When lock.target is stopped, stops this too:
      partOf = [ "lock.target" ];

      # Delay lock.target until this service is ready:
      before = [ "lock.target" ];
      wantedBy = [ "lock.target" ];

      serviceConfig = {
        # systemd will consider this service started when i3lock forks...
        Type = "forking";

        # ... and i3lock will fork only after it has locked the screen.
        ExecStart = "${lib.getExe pkgs.i3lock}";

        # If i3lock crashes, always restart it immediately:
        Restart = "on-failure";
        RestartSec = 0;
      };
    };

    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;
      displayManager = {
        defaultSession = "none+i3";
        lightdm = {
          enable = true;
          greeter.enable = false;
          autoLogin = {
            enable = true;
            user = "moritzs";
          };
        };
      };
      xautolock =
        let
          lockCmd = "${pkgs.i3lock}/bin/i3lock -c 000000";
          notifyCmd = "${pkgs.libnotify}/bin/notify-send 'Locking screen in 15 seconds'";
        in
        {
          enable = true;
          time = 5; # minutes
          locker = lockCmd;
          notify = 15; # seconds
          notifier = notifyCmd;
        };
    };

    services.autorandr = {
      enable = true;
      profiles = {
        work = {
          fingerprint = {
            "DP-8" = "00ffffffffffff0010ac00d142484c30161f0104a53c22783a4c55a9554d9d260f5054a54b008100b300d100714fa9408180d1c00101565e00a0a0a029503020350055502100001a000000ff004a4a4d4a4b35330a2020202020000000fc0044454c4c205032373230440a20000000fd00314b1d711c010a2020202020200142020314b14f90050403020716010611121513141f023a801871382d40582c450055502100001e011d8018711c1620582c250055502100009e7e3900a080381f4030203a0055502100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b2";
            "DP-9" = "00ffffffffffff0010ac00d142465930161f0104a53c22783a4c55a9554d9d260f5054a54b008100b300d100714fa9408180d1c00101565e00a0a0a029503020350055502100001a000000ff0032534d4a4b35330a2020202020000000fc0044454c4c205032373230440a20000000fd00314b1d711c010a2020202020200146020314b14f90050403020716010611121513141f023a801871382d40582c450055502100001e011d8018711c1620582c250055502100009e7e3900a080381f4030203a0055502100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b2";
            "eDP-1" = "00ffffffffffff004c83934100000000231e0104b51e1378020cf1ae523cb9230c505400000001010101010101010101010101010101a4c34050b0085070082088002ebd1000001ba4c34050b008fc73082088002ebd1000001b0000000f00ff0a5aff0a3c28800000000000000000fe0041544e413430594b31352d3020016202030f00e3058000e606050174600700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b7";
          };
          config = {
            "DP-8" = {
              enable = true;
              position = "0x0";
              mode = "2560x1440";
              rate = "60.00";
            };
            "DP-9" = {
              enable = true;
              primary = true;
              position = "2560x0";
              mode = "2560x1440";
              rate = "60.00";
            };
            "eDP-1" = {
              enable = true;
              position = "5120x0";
              scale = {
                x = 2;
                y = 2;
              };
              mode = "2880x1800";
              rate = "120.00";
            };
          };
        };
      };
    };
  };
}
