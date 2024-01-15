{ pkgs, ... }: {
  # Exposes D-Bus interfaces for application intents
  # such as file access, printing, etc.
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
      config.common.default = "*";
    };
  };

  home-manager.users.moritzs = { pkgs, ... }: {
    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "sway";
    };

    xdg.configFile."nixpkgs/config.nix".text = ''
      {
        allowUnfree = true;
      }
    '';
  };
}
