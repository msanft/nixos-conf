{ config, pkgs, ... }:
let
  discordScript = pkgs.writeShellApplication {
    name = "discord";
    runtimeInputs = [ pkgs.chromium ];
    text = ''
      swaymsg exec 'chromium --app=https://discord.com/app'
    '';
  };

  discordDesktopItem = pkgs.makeDesktopItem {
    name = "discord";
    exec = "${discordScript}/bin/discord";
    desktopName = "Discord";
    genericName = "Communication";
    comment = "Discord as Chromium web app.";
    startupWMClass = "discord";
    terminal = true;
  };
in
{
  home.packages = [ discordDesktopItem discordScript ];
}
