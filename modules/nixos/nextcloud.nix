{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.grafana;
in
{
  options.my.nextcloud = with lib; {
    enable = mkEnableOption "Serve Nextcloud.";
  };

  imports = [
    ./caddy.nix
  ];

  config = lib.mkIf cfg.enable {
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud29;
      https = true;
      hostName = "cloud.msanft.home";
      enableImagemagick = true;
      database.createLocally = true;
      configureRedis = true;
      maxUploadSize = "16G";
      autoUpdateApps.enable = true;
      extraAppsEnable = true;
      config = {
        overwriteProtocol = "https";
        defaultPhoneRegion = "DE";
        dbtype = "pgsql";
        adminuser = "admin";
        adminpassFile = "/etc/nextcloud-pass";
      };
    };

    services.nginx.virtualHosts."cloud.msanft.home".listen = [ { addr = "127.0.0.1"; port = 8810; } ];

    services.caddy.virtualHosts = {
      "cloud.msanft.home" = {
        extraConfig = ''
          tls internal

          reverse_proxy localhost:8810
        '';
      };
    };
  };
}
