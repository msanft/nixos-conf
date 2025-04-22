{
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/nix/remote-builders.nix
    ../../modules/nixos/secureboot.nix
    ../../profiles/desktop
  ];

  networking.hostName = "tp";

  users.users.msanft.extraGroups = [
    "networkmanager"
    "wireshark"
  ];
  networking.networkmanager.enable = true;

  my.secureboot.enable = false;

  boot.supportedFilesystems = [ "nfs" ];

  programs.wireshark.enable = true;
  environment.systemPackages = [ pkgs.wireshark ];

  # For routing all traffic through WireGuard
  networking.firewall.checkReversePath = false;

  system.stateVersion = "22.11";
}
