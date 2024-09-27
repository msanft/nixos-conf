{
  config,
  lib,
  pkgs,
  ...
}:

{
    # Integration with GPG (used for SSH, Git, etc.)
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    services = {
      gnome.gnome-keyring.enable = true;
      pcscd.enable = true;
      udev.packages = [ pkgs.yubikey-personalization ];
    };

    # Login and authentication
    security = {
      polkit.enable = true;
      pam = {
        u2f = {
          enable = true;
          settings.cue = true;
        };

        services = {
          greetd.enableGnomeKeyring = true;
        };
      };
    };

    # Locks the screen when the YubiKey is removed
    services.udev.extraRules = ''
      ACTION=="remove",\
       ENV{ID_BUS}=="usb",\
       ENV{ID_MODEL_ID}=="0407",\
       ENV{ID_VENDOR_ID}=="1050",\
       ENV{ID_VENDOR}=="Yubico",\
       RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
    '';
    services.systemd-lock-handler.enable = true;
}
