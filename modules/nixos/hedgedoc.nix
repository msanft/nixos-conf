{
  config,
  lib,
  ...
}:
let
  cfg = config.my.hedgedoc;
in
{
  options.my.hedgedoc = with lib; {
    enable = mkEnableOption "Serve Hedgedoc.";
  };

  imports = [
    ./caddy.nix
    ./dyndns.nix
  ];

  config = lib.mkIf cfg.enable {
    services.hedgedoc = {
      enable = true;
      settings = {
        domain = "pad.msanft.foo";
        protocolUseSSL = true;
      };
    };

    services.caddy.virtualHosts = {
      "pad.msanft.foo" = {
        extraConfig = ''
          reverse_proxy localhost:${toString config.services.hedgedoc.settings.port}
        '';
      };
    };

    networking.firewall.allowedTCPPorts = [ config.services.hedgedoc.settings.port ];

    my.dyndns.domains = [ "pad.msanft.foo" ];
  };
}
