{ pkgs, ... }: {
  imports = [
    ./chromium.nix
    ./teams.nix
    ./discord.nix
  ];
}
