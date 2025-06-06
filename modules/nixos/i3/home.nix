{
  config,
  lib,
  pkgs,
  ...
}:
{
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;

      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "${pkgs.rofi}/bin/rofi -show drun -show-icons -pid";
        bars = [
          {
            position = "bottom";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-bottom.toml";
          }
        ];
        keybindings =
          let
            mod = config.xsession.windowManager.i3.config.modifier;
          in
          lib.mkOptionDefault {
            "${mod}+Shift+l" = "exec ${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 10 pixel";
            "${mod}+Shift+p" = "exec ${pkgs.maim}/bin/maim -s | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
          };
      };

      extraConfig = ''
        # force border for all windows
        for_window [class=".*"] border normal 1
      '';
    };
  };

  programs.i3status-rust = {
    enable = true;
    bars.bottom = {
      blocks = [
        {
          alert = 10.0;
          block = "disk_space";
          info_type = "available";
          interval = 60;
          path = "/";
          warning = 20.0;
        }
        {
          block = "memory";
          format = " $icon $mem_used_percents ";
          format_alt = " $icon $swap_used_percents ";
        }
        {
          block = "cpu";
        }
        {
          block = "net";
          format = " $icon {$signal_strength $ssid $frequency|Wired} via $device ";
        }
        {
          block = "sound";
        }
        {
          block = "time";
          format = " $timestamp.datetime(f:'%a %d/%m %R') ";
        }
      ];
      settings.theme.overrides = {
        idle_fg = "#ffffff";
      };
    };
  };

  programs.rofi = {
    enable = true;
    theme = "Arc";
  };

  # Disables Home-Manager keyboard management
  home.keyboard = null;

  home.pointerCursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    gtk.enable = true;
    x11.enable = true;
    size = 24;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Arc";
      package = pkgs.arc-icon-theme;
    };
  };

  # notifications
  services.dunst = {
    enable = true;
  };
}
