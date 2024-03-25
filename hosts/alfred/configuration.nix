{ pkgs, rpiKernelPkgs, system, inputs, modulesPath, ... }: {
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    ../../modules/services/ssh
    ../../modules/services/tailscale
    ../../modules/nix
  ];

  networking.hostName = "alfred";

  # disable zfs so we can use a recent kernel
  # see https://github.com/NixOS/nixpkgs/blob/f8efa87fb581c6a63eca14a552988bbb097af4ed/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix#L6-L14
  nixpkgs.overlays = [
    (final: super: {
      zfs = super.zfs.overrideAttrs (_: {
        meta.platforms = [ ];
      });
    })
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  users.users.msanft = {
    isNormalUser = true;
    description = "Moritz Sanft";
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
  };

  sdImage.compressImage = false;

  services.getty.autologinUser = "msanft";

  environment.systemPackages = with pkgs; [
    libraspberrypi
  ];

  my.services.tailscale.enable = true;
  my.services.ssh = {
    enable = true;
    server = true;
    allowedUsers = [ "msanft" ];
  };

  console.enable = false;

  boot.kernelPackages =
    let
      rpiPkgs = import rpiKernelPkgs { inherit system; };
    in
    rpiPkgs.linuxPackages_rpi5;

  system = {
    stateVersion = "24.05";
  };
}
