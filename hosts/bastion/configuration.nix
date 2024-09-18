{ pkgs, ... }:
{
  imports = [
    ../../profiles/desktop
    ../../modules/system/nvidia
  ];

  networking.hostName = "bastion";

  boot.supportedFilesystems = [ "nfs" ];

  boot.initrd.systemd.network.enable = true;

  networking = {
    networkmanager.enable = false;
    useNetworkd = true;
  };

  systemd.network = {
    enable = true;

    networks."10-eno2" = {
      matchConfig.Name = "eno2";
      networkConfig.DHCP = "ipv4";
    };
  };

  system.stateVersion = "24.05";
}
