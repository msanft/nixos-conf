{ config, pkgs, ... }:
let
  finalPkg = name: "${config.programs.${name}.finalPackage}";
  finalPkgBin = name: "${finalPkg name}/bin/${name}";
in
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemdIntegration = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "${finalPkgBin "rofi"} -show drun -show-icons -pid";
      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];

      input = {
        "type:keyboard" = {
          xkb_layout = "de";
        };
        "1133:16511:Logitech_G502" = {
          accel_profile = "flat";
          pointer_accel = "-0.3";
        };
      };
    };
  };
}
