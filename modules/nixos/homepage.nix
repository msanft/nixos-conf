{ config
, lib
, ...
}:
let
  cfg = config.my.homepage;
in
{
  options.my.homepage = with lib;
    {
      enable = mkEnableOption "Serve my homepage.";

      package = mkOption {
        type = types.package;
        description = "The directory to serve as the homepage.";
      };
    };

  imports = [ ./caddy.nix ];

  config = lib.mkIf cfg.enable
    {
      services.caddy.virtualHosts = {
        "msanft.foo" = {
          serverAliases = [ "www.msanft.foo" ];
          extraConfig = ''
            encode gzip
            root * ${cfg.package}
            file_server
          '';
        };
      };
    };
}
