{pkgs, ...}: {
    imports = [
        ./google-chrome.nix
        ./teams.nix
        ./discord.nix
    ];
}
