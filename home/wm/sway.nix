{config, pkgs, ...}: {
    wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        systemdIntegration = true;
        config = rec {
            modifier = "Mod4";
            terminal = "alacritty";
            startup = [
                {command = "chromium";}
            ];
            input = {
                "type:keyboard" = {
                    xkb_layout = "de";
                };
            };
        };
    };
}
