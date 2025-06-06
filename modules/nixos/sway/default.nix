{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.sway;
in
{
  options.my.sway = with lib; {
    enable = mkEnableOption "Enable Sway WM.";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.msanft.imports = [
      ./home.nix
    ];

    services.systemd-lock-handler.enable = true;

    systemd.user.services.swaylock = {
      description = "Screen locker for Wayland";
      documentation = [ "man:swaylock(1)" ];

      # If swaylock exits cleanly, unlock the session:
      onSuccess = [ "unlock.target" ];

      # When lock.target is stopped, stops this too:
      partOf = [ "lock.target" ];

      # Delay lock.target until this service is ready:
      before = [ "lock.target" ];
      wantedBy = [ "lock.target" ];

      serviceConfig = {
        # systemd will consider this service started when swaylock forks...
        Type = "forking";

        # ... and swaylock will fork only after it has locked the screen.
        ExecStart = "${lib.getExe pkgs.swaylock-effects} -f";

        # If swaylock crashes, always restart it immediately:
        Restart = "on-failure";
        RestartSec = 0;
      };
    };

    security.pam.services.swaylock = { };

    services.dbus.enable = true;
    programs.dconf.enable = true;

    services.displayManager = {
      defaultSession = "sway";
      autoLogin = {
        enable = true;
        user = "msanft";
      };
    };
  };
}
