{ config, lib, ... }:
let
  cfg = config.my.prometheus;
in
{
  options.my.prometheus = with lib; {
    enable = mkEnableOption "Serve Prometheus.";
  };

  imports = [ ../caddy.nix ];

  config = lib.mkIf cfg.enable {
    services.prometheus = {
      enable = true;
      webExternalUrl = "https://prometheus.msanft.home/";
    };

    services.caddy.virtualHosts = {
      "prometheus.msanft.home" = {
        extraConfig = ''
          tls internal

          reverse_proxy localhost:${toString config.services.prometheus.port}
        '';
      };
    };
  };
}
