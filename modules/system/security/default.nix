{ pkgs, ... }: {
  services = {
    gnome.gnome-keyring.enable = true;
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
  };

  security = {
    polkit.enable = true;
    pam = {
      # Needs to be explicitly enabled so Swaylock can login for us
      services.swaylock = { };
      services.greetd.enableGnomeKeyring = true;
      yubico = {
        enable = true;
        debug = true;
        mode = "challenge-response";
        id = [ "25808654" ];
      };
    };
  };
}
