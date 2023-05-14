{pkgs, ...}: {
    imports = [
        ./sway.nix
    ];

    home.packages = with pkgs; [
        wdisplays
        xdg-utils
        xwayland
    ];
}
