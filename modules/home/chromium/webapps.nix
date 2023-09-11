{ pkgs, ... }:
let
  webapps = {
    teams = pkgs.lib.mkChromiumDesktopApp {
      name = "teams";
      displayName = "Microsoft Teams";
      execScript = "swaymsg exec 'chromium --app=https://teams.microsoft.com/'";
    };
    discord = pkgs.lib.mkChromiumDesktopApp {
      name = "discord";
      displayName = "Discord";
      execScript = "swaymsg exec 'chromium --app=https://discord.com/app/'";
    };
    element = pkgs.lib.mkChromiumDesktopApp {
      name = "element";
      displayName = "Element";
      execScript = "swaymsg exec 'chromium --app=https://app.element.io/'";
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
