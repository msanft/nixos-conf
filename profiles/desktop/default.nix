{
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/services/greetd
    ../../modules/services/input
    ../../modules/nixos/tailscale.nix
    ../../modules/system/i18n
    ../../modules/system/audio
    ../../modules/system/fonts
    ../../modules/nix
    ../../modules/nixos/yubikey.nix
    ../../modules/nixos/i3
    ./packages.nix
  ];

  users.users.msanft = {
    isNormalUser = true;
    description = "Moritz Sanft";
    extraGroups = [
      "wheel"
      "docker"
      "audio"
    ];
    shell = pkgs.bash;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.msanft =
      { ... }:
      {
        home.stateVersion = "24.05";
        imports = [ ./home.nix ];
      };
  };

  # Exposes D-Bus interfaces for application intents
  # such as file access, printing, etc.
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
      config.common.default = "*";
    };
  };

  zramSwap.enable = true;

  networking.networkmanager.wifi.backend = "iwd";

  system.switch = {
    enable = false;
    enableNg = true;
  };

  services.dbus.implementation = "broker";

  boot = {
    tmp.useTmpfs = true;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.systemd.enable = true;

    kernelPackages = pkgs.linuxPackages_latest;
  };

  my.i3.enable = true;

  services.fwupd.enable = true;

  services.resolved.enable = true;

  networking.extraHosts = ''
    127.0.0.1    license.confidential.cloud
    127.0.0.1    mastodon.local
  '';
}
