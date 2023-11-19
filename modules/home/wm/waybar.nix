{ pkgs, ... }: {
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
          on-scroll-up = "bash -c 'brightnessctl -d intel_backlight s 10%+'";
          on-scroll-down = "bash -c 'brightnessctl -d intel_backlight s 10%-'";
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
            default = [ "" "" ];
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
