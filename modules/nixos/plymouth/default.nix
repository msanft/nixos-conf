{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.plymouth;
in
{
  options.my.plymouth = with lib; {
    enable = mkEnableOption "Enable Plymouth boot splash.";
  };

  config = lib.mkIf cfg.enable {
    boot.plymouth.enable = true;
  };
}
