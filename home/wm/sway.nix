{config, pkgs, ...}: let
  finalPkg = name: "${config.programs.${name}.finalPackage}";
  finalPkgBin = name: "${finalPkg name}/bin/${name}";
in {
    imports = [
        ./kanshi.nix
        ./rofi.nix
    ];

    wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        systemdIntegration = true;
        config = rec {
            modifier = "Mod4";
            terminal = "alacritty";
            menu = "${finalPkgBin "rofi"} -show drun -show-icons -pid";

            input = {
                "type:keyboard" = {
                    xkb_layout = "de";
                };
            };
        };
    };
}
