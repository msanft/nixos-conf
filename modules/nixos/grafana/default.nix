{ config
, lib
, ...
}:
let
  cfg = config.my.grafana;
in
{
  options.my.grafana = with lib;
    {
      enable = mkEnableOption "Serve Grafana.";
    };

  imports = [
    ../caddy.nix
  ];

  config = lib.mkIf cfg.enable
    {
      services.grafana = {
        enable = true;
        settings = {
          server = {
            root_url = "https://grafana.msanft.home";
            http_port = 3030;
          };
        };
      };

      services.caddy.virtualHosts = {
        "grafana.msanft.home" = {
          extraConfig = ''
            tls internal

            reverse_proxy localhost:${toString config.services.grafana.settings.server.http_port}
          '';
        };
      };
    };
}
