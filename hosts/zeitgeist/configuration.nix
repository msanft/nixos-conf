{ config, lib, pkgs, inputs, modulesPath, ... }: {
  imports = [
    ../../modules/nix
    ../../modules/nixos/server.nix
    ../../modules/nixos/home-assistant.nix
  ];

  networking.hostName = "zeitgeist";

  services.openssh.settings = {
    PasswordAuthentication = false;
    PermitRootLogin = "without-password";
  };

  systemd.network.networks."10-lan" = {
    matchConfig.Name = "en*";
    networkConfig.DHCP = "yes";
    linkConfig.RequiredForOnline = "routable";
  };

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
