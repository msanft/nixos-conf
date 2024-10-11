{
  ...
}:
{
  imports = [
    ../../modules/nix/remote-builders.nix
    ../../modules/nixos/secureboot.nix
    ../../profiles/desktop
  ];

  networking.hostName = "tp";

  users.users.msanft.extraGroups = [ "networkmanager" ];
  networking.networkmanager.enable = true;

  my.secureboot.enable = true;

  boot.supportedFilesystems = [ "nfs" ];

  # For routing all traffic through WireGuard
  networking.firewall.checkReversePath = false;

  system.stateVersion = "22.11";
}
