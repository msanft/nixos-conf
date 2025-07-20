{
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
    };
  };

  hardware.gpgSmartcards.enable = true;

  programs.bash.loginShellInit = ''
    GPG_TTY="$(${pkgs.coreutils}/bin/tty)"
    export GPG_TTY
    ${pkgs.gnupg}/bin/gpg-connect-agent --quiet updatestartuptty /bye > /dev/null
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
  '';

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
