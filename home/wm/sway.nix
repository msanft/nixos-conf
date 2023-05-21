{config, pkgs, ...}: {
    imports = [
        ./kanshi.nix
    ];

    wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        systemdIntegration = true;
        config = rec {
            modifier = "Mod4";
            terminal = "alacritty";
            input = {
                "type:keyboard" = {
                    xkb_layout = "de";
                };
            };
        };
    };
}
