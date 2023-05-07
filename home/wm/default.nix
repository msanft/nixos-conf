{pkgs, ...}: {
    imports = [
        ./sway.nix
    ];

    home.packages = with pkgs; [
        kanshi
        wdisplays
        wl-clipboard
    ];
}
