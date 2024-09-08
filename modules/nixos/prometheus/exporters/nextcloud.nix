{ config, lib, ... }:
let
  cfg = config.my.prometheus.exporters.nextcloud;
in
{
  options.my.prometheus.exporters.nextcloud = with lib; {
    enable = mkEnableOption "Collect nextcloud metrics.";
  };

  config = lib.mkIf cfg.enable {
    services.prometheus = {
      exporters.nextcloud = {
        enable = true;
        username = "exporter";
        passwordFile = "/etc/nextcloud-exporter-pass";
        url = "http://localhost:8810";
      };

      scrapeConfigs = [
        {
          job_name = "nextcloud";
          static_configs = [
            { targets = [ "localhost:${toString config.services.prometheus.exporters.nextcloud.port}" ]; }
          ];
        }
      ];
    };
  };
}
