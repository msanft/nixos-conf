{ pkgs, ... }: {
  imports = [
    ./chromium.nix
    ./teams.nix
    ./discord.nix
  ];

  home.packages = with pkgs; [
    slack
  ];
}
