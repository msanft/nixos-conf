{
  pkgs,
  config,
  ...
}:
let
  webapps = {
    teams = pkgs.lib.mkDesktopApp {
      name = "teams";
      displayName = "Microsoft Teams";
      runtime = pkgs.chromium;
      execScript = "${config.xsession.windowManager.i3.package}/bin/i3-msg 'exec chromium --app=https://teams.microsoft.com/'";
    };
    discord = pkgs.lib.mkDesktopApp {
      name = "discord";
      displayName = "Discord";
      runtime = pkgs.chromium;
      execScript = "${config.xsession.windowManager.i3.package}/bin/i3-msg 'exec chromium --app=https://discord.com/app/'";
    };
  };
in
{
  home.packages = [
    webapps.teams.script
    webapps.teams.desktopItem
    webapps.discord.script
    webapps.discord.desktopItem
  ];
}
