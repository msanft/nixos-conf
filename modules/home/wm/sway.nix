{ config, pkgs, lib, ... }:
let
  finalPkg = name: "${config.programs.${name}.finalPackage}";
  finalPkgBin = name: "${finalPkg name}/bin/${name}";
  border = "#4c7899";
  background = "#285577";
  text = "#ffffff";
  indicator = "#4c7899";
  childBorder = "#285577";
  dark = "#323232";
  alert = "#ff0000";
in
{
  home.keyboard = null;

  wayland.windowManager.sway = {
    enable = true;

    checkConfig = false;

    config = {
      terminal = "alacritty";
      menu = "${finalPkgBin "rofi"} -show drun -show-icons -pid";
      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];

      colors = {
        focusedInactive = {
          border = border;
          background = background;
          text = text;
          indicator = indicator;
          childBorder = childBorder;
        };

        unfocused = {
          border = dark;
          background = dark;
          text = text;
          indicator = dark;
          childBorder = dark;
        };

        urgent = {
          border = alert;
          background = alert;
          text = dark;
          indicator = alert;
          childBorder = alert;
        };
      };

      input = {
        "type:keyboard" = {
          xkb_layout = "us-custom,de-custom";
        };
        "1133:16511:Logitech_G502" = {
          accel_profile = "flat";
          pointer_accel = "-0.3";
        };
        "9610:54:Glorious_Model_O" = {
          accel_profile = "flat";
          pointer_accel = "0.2";
        };
      };

      modifier = "Mod4";

      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${mod}+p" = "exec ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g- screenshot-$(date +%Y%m%d-%H%M%S).png";
          "${mod}+Shift+p" = "exec ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g- - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png";
          "${mod}+l" = "exec ${pkgs.swaylock-effects}/bin/swaylock";
        };

      window = {
        commands = [
          {
            criteria.shell = "xwayland";
            command = "title_format \"%title :: %shell\"";
          }
        ];
      };
    };
  };
  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
