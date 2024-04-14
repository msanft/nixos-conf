{ pkgs, ... }: {
  services = {
    gnome.gnome-keyring.enable = true;
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
  };

  security = {
    polkit.enable = true;
    pam = {
      yubico = {
        enable = true;
        mode = "challenge-response";
        id = [ "25808654" ];
      };

      services = {
        # Needs to be explicitly enabled so Swaylock can login for us
        swaylock = { };
        greetd.enableGnomeKeyring = true;

        login.u2fAuth = true;
        sudo.u2fAuth = true;
      };
    };
  };
}
