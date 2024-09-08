{ homepage, ... }:
{
  imports = [
    ../../modules/nix
    ../../modules/nixos/server.nix
    ../../modules/nixos/dyndns.nix
    ../../modules/nixos/homepage.nix
    ../../modules/nixos/hedgedoc.nix
    ../../modules/nixos/prometheus
    ../../modules/nixos/grafana
    ../../modules/nixos/loki
    ../../modules/nixos/prometheus/exporters/node-exporter.nix
    ../../modules/nixos/prometheus/exporters/caddy.nix
    ../../modules/nixos/prometheus/exporters/nextcloud.nix
    ../../modules/nixos/home-assistant.nix
    ../../modules/nixos/nextcloud.nix
  ];

  networking.hostName = "zeitgeist";

  services.openssh.settings = {
    PermitRootLogin = "without-password";
  };

  my.homepage = {
    enable = true;
    package = homepage;
  };

  my.hedgedoc.enable = true;

  my.nextcloud.enable = true;

  my.prometheus = {
    enable = true;
    exporters = {
      node.enable = true;
      caddy.enable = true;
      nextcloud.enable = true;
    };
  };

  my.grafana.enable = true;

  my.loki.enable = true;

  my.dyndns.enable = true;

  systemd.network.networks."10-lan" = {
    matchConfig.Name = "en*";
    networkConfig.DHCP = "yes";
    linkConfig.RequiredForOnline = "routable";
  };
  systemd.network.wait-online.anyInterface = true;
  networking.networkmanager.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  boot.supportedFilesystems = [ "btrfs" ];

  networking.firewall.extraCommands = ''
    # Silence stupid smart TV
    iptables \
      --insert nixos-fw-log-refuse 1 \
      --source 192.168.2.108 \
      --protocol tcp \
      --jump nixos-fw-refuse

    iptables \
      --insert nixos-fw-log-refuse 1 \
      --source 192.168.2.1 \
      --protocol tcp \
      --jump nixos-fw-refuse
  '';

  system.stateVersion = "22.11";
}
