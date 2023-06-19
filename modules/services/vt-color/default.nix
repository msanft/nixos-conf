{ pkgs, ... }: {
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
