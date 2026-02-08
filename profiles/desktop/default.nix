{ pkgs
, ...
}:
{
  imports = [
    ../../modules/services/input
    ../../modules/nixos/tailscale.nix
    ../../modules/system/i18n
    ../../modules/system/audio
    ../../modules/system/fonts
    ../../modules/nix
    ../../modules/nixos/yubikey
    ../../modules/nixos/gnome
    ../../modules/nixos/plymouth
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

  virtualisation.docker.enable = true;

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

  my.gnome.enable = true;
  my.plymouth.enable = true;

  services.fwupd.enable = true;

  services.resolved.enable = true;

  networking.extraHosts = ''
    127.0.0.1    license.confidential.cloud
    127.0.0.1    ampcode.com
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
    # mkcert
    ''
      -----BEGIN CERTIFICATE-----
      MIIEvTCCAyWgAwIBAgIQYFg6ymHudCLKfn7eOHKYjzANBgkqhkiG9w0BAQsFADB3
      MR4wHAYDVQQKExVta2NlcnQgZGV2ZWxvcG1lbnQgQ0ExJjAkBgNVBAsMHW1zYW5m
      dEBiYXN0aW9uIChNb3JpdHogU2FuZnQpMS0wKwYDVQQDDCRta2NlcnQgbXNhbmZ0
      QGJhc3Rpb24gKE1vcml0eiBTYW5mdCkwHhcNMjYwMTIwMDc1MzE2WhcNMzYwMTIw
      MDc1MzE2WjB3MR4wHAYDVQQKExVta2NlcnQgZGV2ZWxvcG1lbnQgQ0ExJjAkBgNV
      BAsMHW1zYW5mdEBiYXN0aW9uIChNb3JpdHogU2FuZnQpMS0wKwYDVQQDDCRta2Nl
      cnQgbXNhbmZ0QGJhc3Rpb24gKE1vcml0eiBTYW5mdCkwggGiMA0GCSqGSIb3DQEB
      AQUAA4IBjwAwggGKAoIBgQCuKRlozBwhY0zb2HWfhvGErt4BlUhMTcdcc8aQMdmv
      HVkhLPRC+7x+Q/PHxynU5IMyvJt1QlqssBsQzUVR9+XGv9uVags1VzTyVfTkO5bM
      /TSNbx9f+lsMZ0D5QX1aXu5oOdQyXpsncrN19Rf5al7zlhiPgEZEL58kOoKjmg4f
      BpNcMpG4t21kNhbpHym0zo/ATtm1M6hlJ5+C031WbWf2/ODi5Yur79thdqmty9c2
      8TCStoZx+oesmKJQolwK4BqqFzLh+4+mA7v5EptyDU6T0cng2QtMSEF3u55+/hCZ
      wneA39+Uw1ZcskTkGD6H8rmap8UeNkMuFyejws6DJ+BsXPvV46PZzMbgi23gwLat
      ExfJ7Bw6/449G2VB88sL/mg2yao3xUZ4Rs5kS/JVHEWJ7NvGqoQGnFGjVsXuO4yZ
      +Yokm/foo4qrKRKCrK5+QcDUtA4hGBMtzTs2Xh/nrJRUZ4nOVgvdhyhKsz9GTS0r
      uJdf07DtFDVmOqmftKQH7f8CAwEAAaNFMEMwDgYDVR0PAQH/BAQDAgIEMBIGA1Ud
      EwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFG5XJ/h1v2aGNQIKOcy1h9cGTWfWMA0G
      CSqGSIb3DQEBCwUAA4IBgQCM2C5ESxbbeXThlIwldCymPVx642YISkeDwW5eQg4d
      TK90PrzuUnarbUEKgY1f2VLre0ffzNSQDa2By6Z8BUh8EJQtwJI+m5fuv1XzDXOX
      MHlmHM/b9ooobKexJq+2TnqupflOpBf8Aic+Us/e5k6VjkiGBLHxYcYL555mP0qA
      e26q/UpnImTVU4bfwbKFpwdDc3MX3Bj/arLo5aIRGxcguqmDtdTJmqTPH80XpoUF
      Jh4HQ3tOTEnYq/e1d+4asj5M0auk4A9CN8yxU60Ads5TxGD6cJhIp+ZMkdALRJLu
      3x/FA4D43HsExbFx99vkNj8WQhU1zhpm3r1Hs9r0WsJTFTvdk1Z87mplmUt2Hq9c
      77WKX945wj9rrDMguyqgw7VcSgpJ/qtFY961jun7ijhklKhijkDS29x5RavfxFI/
      QqgmAMcRuzo/Win/10qMoGdjX0gF8Ena+BUQSQwp4VB9l0I1mAzN0TWhC7pDYDqM
      oypgQ5HRlZ8N1E/qIkAoA6w=
      -----END CERTIFICATE-----
    ''
  ];
}
