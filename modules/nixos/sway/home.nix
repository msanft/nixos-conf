{
  config,
  pkgs,
  lib,
  ...
}:
let
  finalPkg = name: "${config.programs.${name}.finalPackage}";
  finalPkgBin = name: "${finalPkg name}/bin/${name}";
  border = "#4c7899";
  background = "#285577";
  text = "#ffffff";
  indicator = "#4c7899";
  childBorder = "#285577";
  dark = "#323232";
  alert = "#ff0000";
in
{
  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  home.packages = with pkgs; [
    swayimg
    xdg-utils
    xwayland
    kanshi
    grim
    slurp
    wl-clipboard
  ];

  wayland.windowManager.sway = {
    enable = true;

    checkConfig = false;

    config = {
      terminal = "alacritty";
      menu = "${finalPkgBin "rofi"} -show drun -show-icons -pid";
      bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];

      colors = {
        focusedInactive = {
          border = border;
          background = background;
          text = text;
          indicator = indicator;
          childBorder = childBorder;
        };

        unfocused = {
          border = dark;
          background = dark;
          text = text;
          indicator = dark;
          childBorder = dark;
        };

        urgent = {
          border = alert;
          background = alert;
          text = dark;
          indicator = alert;
          childBorder = alert;
        };
      };

      input = {
        "type:keyboard" = {
          xkb_layout = "us-custom,de-custom";
        };
        "1133:16511:Logitech_G502" = {
          accel_profile = "flat";
          pointer_accel = "-0.3";
        };
        "9610:54:Glorious_Model_O" = {
          accel_profile = "flat";
          pointer_accel = "0.2";
        };
      };

      modifier = "Mod4";

      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${mod}+p" = "exec ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g- screenshot-$(date +%Y%m%d-%H%M%S).png";
          "${mod}+Shift+p" = "exec ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g- - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png";
          "${mod}+l" = "exec ${pkgs.swaylock-effects}/bin/swaylock";
        };

      window.commands = [
        {
          criteria.shell = "xwayland";
          command = "title_format \"%title :: %shell\"";
        }
      ];
    };
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

  services.kanshi =
    let
      dellG3223D = {
        name = "Dell Inc. DELL G3223D";
        sizeX = "2560";
        sizeY = "1440";
        refreshRate = "120Hz";
      };
      dellP2720D = {
        name = "Dell Inc. DELL P2720D";
        sizeX = "2560";
        sizeY = "1440";
        refreshRate = "59.951Hz";
      };
    in
    {
      enable = true;

      profiles = {
        netzlabor.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "0,1080";
            scale = 1.0;
          }
          {
            criteria = "*";
            status = "enable";
            position = "0,0";
          }
        ];

        docked.outputs = [
          {
            criteria = "${dellG3223D.name} H916XG3";
            status = "enable";
            mode = "${dellG3223D.sizeX}x${dellG3223D.sizeY}@${dellG3223D.refreshRate}";
            position = "0,0";
          }
          {
            criteria = "${dellG3223D.name} HBN6XG3";
            status = "enable";
            mode = "${dellG3223D.sizeX}x${dellG3223D.sizeY}@${dellG3223D.refreshRate}";
            position = "${dellG3223D.sizeX},0";
          }
          {
            criteria = "eDP-1";
            status = "disable";
            position = "0,0";
          }
        ];

        office.outputs = [
          {
            criteria = "${dellP2720D.name} JJMJK53";
            status = "enable";
            mode = "${dellP2720D.sizeX}x${dellP2720D.sizeY}@${dellP2720D.refreshRate}";
            position = "0,0";
          }
          {
            criteria = "${dellP2720D.name} 2SMJK53";
            status = "enable";
            mode = "${dellP2720D.sizeX}x${dellP2720D.sizeY}@${dellP2720D.refreshRate}";
            position = "${dellP2720D.sizeX},0";
          }
          {
            criteria = "eDP-1";
            status = "enable";
            position = "5120,0"; # dellP2720D.sizeX * 2
            scale = 1.0;
          }
        ];

        undocked.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "0,0";
            scale = 1.0;
          }
        ];

        parents.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "2560,0";
          }
          {
            criteria = "ASUSTek COMPUTER INC VG32AQA1A RCLMQS032087";
            status = "enable";
            mode = "2560x1440@144.001Hz";
            position = "0,0";
          }
        ];
      };
    };

  services.mako = {
    enable = true;
    defaultTimeout = 2000;
  };

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "sway";
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland; # wayland native replacement
    theme = "Arc";
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "swaylock -f";
      }
    ];
    timeouts = [
      {
        timeout = 240;
        command = "swaylock -f";
      }
      {
        timeout = 600;
        command = "swaymsg 'output * power off'";
        resumeCommand = "swaymsg 'output * power on'";
      }
    ];
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      clock = true;
      indicator = true;
      effect-pixelate = 30;
    };
  };

  programs.waybar = {
    enable = true;
    systemd.target = "sway-session.target";
    style = builtins.readFile ./waybar.css;

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        modules-left = [
          "sway/workspaces"
          "sway/window"
          "sway/mode"
        ];

        modules-right = [
          "pulseaudio"
          "network"
          "sway/language"
          "disk"
          "memory"
          "cpu"
          "temperature"
          "backlight"
          "battery"
          "clock#time"
          "clock#date"
        ];

        # Modules

        "backlight" = {
          interval = 10;
          device = "intel_backlight";
          format = "<span font=\"Font Awesome 6 Free\"></span> {percent}%";
          on-scroll-up = "bash -c 'brightnessctl -d amdgpu_bl1 s 10%+'";
          on-scroll-down = "bash -c 'brightnessctl -d amdgpu_bl1 s 10%-'";
        };

        "battery" = {
          interval = 10;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "<span font=\"Font Awesome 6 Free\">{icon}</span> {capacity}%";
          format-charging = "<span font=\"Font Awesome 6 Free\"></span> {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "clock#time" = {
          interval = 10;
          format = "{:%H:%M:%S}";
        };

        "clock#date" = {
          interval = 20;
          format = "{:%d.%m.%y}";
        };

        "cpu" = {
          interval = 5;
          tooltip = false;
          format = "<span font=\"Font Awesome 6 Free\"></span> {usage}%";
          format-alt = "<span font=\"Font Awesome 6 Free\"></span> {load}";
          states = {
            warning = 70;
            critical = 90;
          };
          on-click-right = "swaymsg exec 'alacritty -e btop'";
        };

        "disk" = {
          interval = 15;
          format = "<span font=\"Font Awesome 6 Free\"></span> {percentage_used}%";
        };

        "memory" = {
          interval = 5;
          format = "<span font=\"Font Awesome 6 Free\"></span> {}%";
          states = {
            warning = 70;
            critical = 90;
          };
          on-click-right = "swaymsg exec 'alacritty -e btop'";
        };

        "network" = {
          interval = 5;
          format-wifi = "<span font=\"Font Awesome 6 Free\"></span> {essid} ({signalStrength}%)";
          format-ethernet = "<span font=\"Font Awesome 6 Free\">󰈁</span> {ifname}";
          format-disconnected = "No connection";
          format-alt = "<span font=\"Font Awesome 6 Free\">󰛳</span> {ipaddr}/{cidr}";
          on-click-right = "swaymsg exec 'alacritty -e nmtui-connect'";
        };

        "sway/mode" = {
          format = "{}";
        };

        "sway/window" = {
          format = "{}";
          max-length = 50;
        };

        "sway/workspaces" = {
          disable-scroll-wraparound = true;
          smooth-scrolling-threshold = 4;
          enable-bar-scroll = true;
          format = "{name}";
        };

        "pulseaudio" = {
          format = "<span font=\"Font Awesome 6 Free\">{icon}</span> {volume}%";
          format-bluetooth = "<span font=\"Font Awesome 6 Free\">{icon}</span> <span font=\"Font Awesome 6 Free\"></span> {volume}%";
          format-muted = "<span font=\"Font Awesome 6 Free\"></span>";
          format-icons = {
            headphone = "";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
            ];
          };
          scroll-step = 1;
          on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
          on-click-right = "swaymsg exec pavucontrol";
        };

        "temperature" = {
          critical-threshold = 90;
          interval = 5;
          format = "<span font=\"Font Awesome 6 Free\">{icon}</span> {temperatureC}°";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "sway/language" = {
          format = "{}";
          on-click-right = "swaymsg input type:keyboard xkb_switch_layout next";
        };
      };
    };
  };
}
