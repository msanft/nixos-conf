{ config, pkgs, lib, ... }:
let
  finalPkg = name: "${config.programs.${name}.finalPackage}";
  finalPkgBin = name: "${finalPkg name}/bin/${name}";
  background = "#121212";
  foreground = "#cacaca";
  text = "#ffffff";
  primary = "#cae982";
  slight = "#242424";
  dark = "#666666";
  alert = "#e5786d";
in
{
  home.keyboard = null;

  wayland.windowManager.sway = {
    enable = true;

    config = {
      terminal = "alacritty";
      menu = "${finalPkgBin "rofi"} -show drun -show-icons -pid";
      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];

      colors = {
        focused = {
          border = primary;
          background = primary;
          text = background;
          indicator = primary;
          childBorder = primary;
        };

        focusedInactive = {
          border = slight;
          background = slight;
          text = text;
          indicator = slight;
          childBorder = slight;
        };

        unfocused = {
          border = dark;
          background = dark;
          text = foreground;
          indicator = dark;
          childBorder = dark;
        };

        urgent = {
          border = alert;
          background = alert;
          text = background;
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

      window.commands = [
        {
          criteria.shell = "xwayland";
          command = "title_format \"%title :: %shell\"";
        }
      ];
    };
  };
}
