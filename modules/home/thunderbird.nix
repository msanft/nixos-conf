{ lib, config, ... }:
let
  cfg = config.my.thunderbird;
in
{
  options.my.thunderbird = with lib;
    {
      enable = mkEnableOption "Enable the Thunderbird mail client";
    };

  config = lib.mkIf cfg.enable
    {
      programs.thunderbird = {
        enable = true;
        profiles.main = {
          isDefault = true;
          withExternalGnupg = true;
        };
      };
    };
}
