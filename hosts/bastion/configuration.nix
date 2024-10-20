{ pkgs, ... }:
{
  imports = [
    ../../profiles/desktop
    ../../modules/system/nvidia
  ];

  networking.hostName = "bastion";


  boot.initrd.systemd.network.enable = true;

  networking = {
    networkmanager.enable = false;
    useNetworkd = true;
  };

  systemd.network = {
    enable = true;

    networks."10-eno2" = {
      matchConfig.Name = "eno2";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
    };
  };

  users.users.msanft.extraGroups = [ "wireshark" ];
  programs.wireshark.enable = true;
  environment.systemPackages = [ pkgs.wireshark ];

  services.resolved.domains = [ "msanft.home" ];

  system.stateVersion = "24.05";
}
