{pkgs, ...}: {
    programs.alacritty = {
        enable = true;
        settings = {
            selection.save_to_clipboard = true;
            window = {
                padding = {
                x = 20;
                y = 20;
                };
            };
            font = {
                size = 12;
                normal = {
                    family = "JetBrains Mono";
                };
            };
        };
    };
}
