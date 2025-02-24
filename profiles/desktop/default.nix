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

  virtualisation.docker.enable = true;

  services.dbus.implementation = "broker";

  boot = {
    tmp.useTmpfs = true;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.systemd.enable = true;

    # Stick to 6.11, because NVIDIA driver is broken on 6.12
    # See https://github.com/NixOS/nixpkgs/issues/357643
    kernelPackages = pkgs.linuxKernel.packages.linux_6_11;
  };

  my.i3.enable = true;

  services.fwupd.enable = true;

  services.resolved.enable = true;

  networking.extraHosts = ''
    127.0.0.1    license.confidential.cloud
    127.0.0.1    mastodon.local
  '';

  systemd.services.autorandr.after = [ "multi-user.target" ];

  security.pki.certificates = [
    # Caddy
    ''
      -----BEGIN CERTIFICATE-----
      MIIBpDCCAUqgAwIBAgIRAMzh2Rzul+SMU/Ww2TFGhFUwCgYIKoZIzj0EAwIwMDEu
      MCwGA1UEAxMlQ2FkZHkgTG9jYWwgQXV0aG9yaXR5IC0gMjAyNCBFQ0MgUm9vdDAe
      Fw0yNDA3MjYyMDIzMDhaFw0zNDA2MDQyMDIzMDhaMDAxLjAsBgNVBAMTJUNhZGR5
      IExvY2FsIEF1dGhvcml0eSAtIDIwMjQgRUNDIFJvb3QwWTATBgcqhkjOPQIBBggq
      hkjOPQMBBwNCAASC8nbFrKX0Nb8wT6R6hhCeR/ZHYTmIvyQ1KCMEW0Mti+2srfOX
      lC+b5aZbT17sXXilHfan08Nst4nZsVUzKHbko0UwQzAOBgNVHQ8BAf8EBAMCAQYw
      EgYDVR0TAQH/BAgwBgEB/wIBATAdBgNVHQ4EFgQUyIUXVXnou1Ag8mgxQZG457aP
      TUQwCgYIKoZIzj0EAwIDSAAwRQIgI/4E9l0uPu4w+KEVzOMBz7F1HWL2fZYHF9We
      CjhfZMYCIQCA1rWQ2ixNkCwVeF29QgfZDxmhlwBisYuDh1MhreMdBw==
      -----END CERTIFICATE-----
    ''
  ];
}
