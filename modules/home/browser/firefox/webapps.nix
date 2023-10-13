{ pkgs, ... }:
let
  webapps = {
    teams = pkgs.lib.mkDesktopApp {
      name = "teams";
      displayName = "Microsoft Teams";
      runtime = pkgs.firefox;
      execScript = "swaymsg exec 'firefox -ssb https://teams.microsoft.com/'";
    };
    discord = pkgs.lib.mkDesktopApp {
      name = "discord";
      displayName = "Discord";
      runtime = pkgs.firefox;
      execScript = "swaymsg exec 'firefox -ssb https://discord.com/app/'";
    };
    element = pkgs.lib.mkDesktopApp {
      name = "element";
      displayName = "Element";
      runtime = pkgs.firefox;
      execScript = "swaymsg exec 'firefox -ssb https://app.element.io/'";
    };
  };
in
{
  home.packages = with pkgs; [
    webapps.teams.script
    webapps.teams.desktopItem
    webapps.discord.script
    webapps.discord.desktopItem
    webapps.element.script
    webapps.element.desktopItem
  ];
}
