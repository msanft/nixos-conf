{config, pkgs, ...}: {
    wayland.windowManager.sway = {
        enable = true;
        config = rec {
            modifier = "Mod4";
            terminal = "alacritty";
            startup = [
                {command = "chromium";}
            ];
        };
    };
}
