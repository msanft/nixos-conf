{ config, pkgs, lib, ... }:
let
  finalPkg = name: "${config.programs.${name}.finalPackage}";
  finalPkgBin = name: "${finalPkg name}/bin/${name}";
in
{
  home.file."wallpaper.png".source = ./wallpaper.png;

  wayland.windowManager.sway = {
    enable = true;

    config = {
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

      modifier = "Mod4";

      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${mod}+p" = "exec ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g- screenshot-$(date +%Y%m%d-%H%M%S).png";
          "${mod}+Shift+p" = "exec ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g- - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png";
        };

      output = {
        "*".bg = "~/wallpaper.png fill";
      };
    };
  };
}
