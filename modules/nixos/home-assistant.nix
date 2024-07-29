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

      http = {
        base_url = "https://hass.msanft.home";
        use_x_forwarded_for = true;
        trusted_proxies = [
          "127.0.0.1"
          "::1"
        ];
      };

      "automation ui" = "!include automations.yaml";
    };
  };

  services.caddy.virtualHosts = {
    "hass.msanft.home" = {
      extraConfig = ''
        tls internal

        reverse_proxy localhost:8123
      '';
    };
  };

  # If automations.yaml does not exist, home-assistant will error
  systemd.tmpfiles.rules = [
    "f ${config.services.home-assistant.configDir}/automations.yaml 0755 hass hass"
  ];
}
