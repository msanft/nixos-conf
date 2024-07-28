{ config, lib, ... }:
let
  cfg = config.my.loki;
in
{
  options.my.loki = with lib; {
    enable = mkEnableOption "Serve Loki.";
  };

  imports = [ ../caddy.nix ];

  config = lib.mkIf cfg.enable {
    services.loki = {
      enable = true;
      configFile = ./config.yml;
    };

    services.caddy.virtualHosts = {
      "loki.msanft.home" = {
        extraConfig = ''
          tls internal

          reverse_proxy localhost:3100
        '';
      };
    };

    services.promtail = {
      enable = true;
      configuration = {
        server = {
          disable = true;
        };
        clients = [ { url = "http://localhost:3100/loki/api/v1/push"; } ];
        scrape_configs = [
          {
            job_name = "journal";
            journal = {
              max_age = "12h";
              labels = {
                job = "systemd-journal";
                host = config.networking.hostName;
              };
            };
            relabel_configs = [
              {
                source_labels = [ "__journal__systemd_unit" ];
                target_label = "unit";
              }
            ];
          }
        ];
      };
    };
  };
}
