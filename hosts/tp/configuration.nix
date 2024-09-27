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

  system.stateVersion = "22.11";
}
