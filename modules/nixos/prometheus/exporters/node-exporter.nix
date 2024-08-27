{ config, lib, ... }:
let
  cfg = config.my.prometheus.exporters.node;
in
{
  options.my.prometheus.exporters.node = with lib; {
    enable = mkEnableOption "Collect node metrics.";
  };

  config = lib.mkIf cfg.enable {
    services.prometheus = {
      exporters.node = {
        enable = true;
        enabledCollectors = [
          "systemd"
          "processes"
        ];
      };

      scrapeConfigs = [
        {
          job_name = "node-exporter";
          static_configs = [
            { targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ]; }
          ];
        }
      ];
    };
  };
}
