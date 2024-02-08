{ lib, pkgs, config, ... }:
let
  cfg = config.my.services.tailscale;
in
{
  options.my.services.tailscale = with lib;
    {
      enable = mkEnableOption "Build the Tailscale configuration.";
    };

  config = lib.mkIf cfg.enable
    {
      services.tailscale = {
        enable = true;
      };

      environment.systemPackages = with pkgs; [
        tailscale
      ];
    };
}
