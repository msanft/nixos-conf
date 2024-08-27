{ config, lib, ... }:
let
  cfg = config.my.prometheus.exporters.node;
in
{
  options.my.prometheus.exporters.caddy = with lib; {
    enable = mkEnableOption "Collect Caddy metrics.";
  };

  config = lib.mkIf cfg.enable {
    services.caddy.globalConfig = ''
      servers {
        metrics
      }
    '';

    services.prometheus.scrapeConfigs = [
      {
        job_name = "caddy";
        static_configs = [
          { targets = [ "localhost:2019" ]; }
        ];
      }
    ];
  };
}
