{ pkgs, ... }: {
  # Needs to be explicitly enabled so Swaylock can login for us
  security.pam.services.swaylock = { };

  security.polkit.enable = true;
}
