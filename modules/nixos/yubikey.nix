{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.yubikey;
in
{
  options.my.yubikey = with lib; {
    enable = mkEnableOption "Enable YubiKey integration.";
    # id = mkOption {
    #   type = types.str;
    #   description = "The ID of the YubiKey to integrate.";
    # };
  };

  config = lib.mkIf cfg.enable {
    # assertions = [
    #   { assertion = cfg.id != null; message = "You must provide a YubiKey ID."; }
    # ];

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
        # yubico = {
        #   enable = true;
        #   mode = "challenge-response";
        #   id = cfg.id;
        # };

        u2f = {
          enable = true;
          cue = true;
        };

        services = {
          # Needs to be explicitly enabled so Swaylock can login for us
          swaylock = { };
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
  };
}
