{ ... }:
{
  imports = [
    ../../profiles/desktop
    ../../modules/system/nvidia
  ];

  networking.hostName = "bastion";

  users.users.msanft.extraGroups = [ "wireshark" ];
  programs.wireshark.enable = true;
  hardware.nvidia-container-toolkit.enable = true;

  services.resolved.settings.Resolve.Domains = [ "msanft.home" ];

  system.stateVersion = "25.11";
}
