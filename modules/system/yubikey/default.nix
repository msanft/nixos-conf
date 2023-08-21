{ pkgs, ... }: {
  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
  };

  security.pam.yubico = {
    enable = true;
    debug = true;
    mode = "challenge-response";
    id = [ "25808654" ];
  };
}
