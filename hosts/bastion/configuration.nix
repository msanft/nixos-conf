{ ... }:
{
  imports = [
    ../../profiles/desktop
    ../../modules/system/nvidia
  ];

  networking.hostName = "bastion";

  users.users.msanft.extraGroups = [ "wireshark" ];
  programs.wireshark.enable = true;

  services.resolved.domains = [ "msanft.home" ];

  system.stateVersion = "25.11";
}
