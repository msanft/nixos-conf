{ pkgs, ... }:
{
  # Otherwise bootlogs end up in the greeter
  boot.kernelParams = [
    "console=tty1"
  ];

  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session = {
        user = "moritzs";
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --remember --time --asterisks \
          --cmd '${pkgs.sway}/bin/sway'
        '';
      };
    };
  };
}
