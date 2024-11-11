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
    home-manager.users.msanft.imports = [
      ./home.nix
    ];

    services.systemd-lock-handler.enable = true;

    services.dbus.enable = true;

    programs.dconf.enable = true;

    programs.i3lock = {
      enable = true;
      u2fSupport = true;
      package = pkgs.i3lock-fancy-rapid;
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
        ExecStart = "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 10 pixel";

        # If i3lock crashes, always restart it immediately:
        Restart = "on-failure";
        RestartSec = 0;
      };
    };

    services.displayManager = {
      defaultSession = "none+i3";
      autoLogin = {
        enable = true;
        user = "msanft";
      };
    };

    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;
      displayManager = {
        lightdm = {
          enable = true;
          greeter.enable = false;
        };
      };
      xautolock =
        let
          lockCmd = "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 10 pixel";
          notifyCmd = "${pkgs.libnotify}/bin/notify-send 'Locking screen in 15 seconds'";
        in
        {
          enable = true;
          time = 15; # minutes
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
        home = {
          fingerprint = {
            "DP-0" = "00ffffffffffff0010ac39d14c5a4a300f200104b5462878fb26f5af4f46a5240f5054a54b00714f8140818081c081009500b300d1c0565e00a0a0a0295030203500b9882100001a000000ff0048424e365847330a2020202020000000fc0044454c4c204733323233440a20000000fd0030a5fafa41010a2020202020200247020332f149030212110490131f3f2309070783010000e200eae305c000e606050162622c6d1a0000020b30a50007622c622c5a8780a070384d4030203500b9882100001af4fb0050a0a0285008206800b9882100001a40e7006aa0a0675008209804b9882100001a6fc200a0a0a0555030203500b9882100001a00000000000970127903000301147c9700047f079f002f801f0037043100020009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d990";
            "DP-2" = "00ffffffffffff0010ac39d14c584a300f200104b5462878fb26f5af4f46a5240f5054a54b00714f8140818081c081009500b300d1c0565e00a0a0a0295030203500b9882100001a000000ff00483931365847330a2020202020000000fc0044454c4c204733323233440a20000000fd0030a5fafa41010a202020202020026f020332f149030212110490131f3f2309070783010000e200eae305c000e606050162622c6d1a0000020b30a50007622c622c5a8780a070384d4030203500b9882100001af4fb0050a0a0285008206800b9882100001a40e7006aa0a0675008209804b9882100001a6fc200a0a0a0555030203500b9882100001a00000000000970127903000301147c9700047f079f002f801f0037043100020009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d990";
          };
          config = {
            "DP-0" = {
              enable = true;
              position = "2560x0";
              mode = "2560x1440";
              rotate = "right";
              rate = "120.00";
            };
            "DP-2" = {
              enable = true;
              primary = true;
              position = "0x800";
              mode = "2560x1440";
              rate = "120.00";
            };
          };
        };
      };
    };
  };
}
