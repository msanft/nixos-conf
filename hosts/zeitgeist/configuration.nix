{ homepage, ... }: {
  imports = [
    ../../modules/nix
    ../../modules/nixos/server.nix
    ../../modules/nixos/dyndns.nix
    ../../modules/nixos/homepage.nix
    ../../modules/nixos/hedgedoc.nix
    ../../modules/nixos/home-assistant.nix
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

  my.dyndns.enable = true;

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
