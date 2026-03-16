{ pkgs, ... }:
{
  imports = [
    ../../profiles/desktop
    ../../modules/system/nvidia
  ];

  networking.hostName = "bastion";

  programs.wireshark.enable = true;

  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = [ pkgs.virtiofsd ];
  };
  virtualisation.spiceUSBRedirection.enable = true;

  users.users.msanft.extraGroups = [ "wireshark" "libvirtd" ];

  hardware.nvidia-container-toolkit.enable = true;

  services.resolved.settings.Resolve.Domains = [ "msanft.home" ];

  system.stateVersion = "25.11";
}
