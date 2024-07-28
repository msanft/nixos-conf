{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.home-assistant = {
    enable = true;

    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"

      # My Personal components
      "shelly"
      "hue"
    ];

    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = { };

      "automation ui" = "!include automations.yaml";
    };
  };

  services.caddy.virtualHosts = {
    "hass.msanft.home" = {
      extraConfig = ''
        reverse_proxy localhost:8123
      '';
    };
  };

  # If automations.yaml does not exist, home-assistant will error
  systemd.tmpfiles.rules = [
    "f ${config.services.home-assistant.configDir}/automations.yaml 0755 hass hass"
  ];
}
