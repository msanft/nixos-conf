{ config
, lib
, ...
}:
let
  cfg = config.my.dyndns;
in
{
  options.my.dyndns = with lib;
    {
      enable = mkEnableOption "Enable Dynamic DNS.";

      domains = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "List of domains to update.";
      };
    };

  config = lib.mkIf cfg.enable
    {
      services.cloudflare-dyndns = {
        enable = true;
        apiTokenFile = "/etc/cloudflare-dyndns.secret";
        domains = cfg.domains;
      };
    };
}
