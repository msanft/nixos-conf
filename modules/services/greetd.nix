{ pkgs, ... }: {
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

  environment.etc = {
    "gruvbox-vt" = {
      source = ./gruvbox-vt;
      mode = "0777";
    };
  };

  systemd.services."vt-colorscheme" = {
    wantedBy = [ "multi-user.target" ];
    description = "Adjust the VT colorscheme.";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''${pkgs.kbd}/bin/setvtrgb /etc/gruvbox-vt'';
    };
  };
}
