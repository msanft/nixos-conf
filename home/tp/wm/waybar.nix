{ config, pkgs, ... }: {
  # heavily inspired by https://git.sr.ht/~begs/dotfiles/tree/master/item/.config/waybar
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
          "disk"
          "memory"
          "cpu"
          "temperature"
          "battery"
          "clock#time"
          "clock#date"
        ];

        # Modules

        "battery" = {
          interval = 10;
          states = {
            warning = 30;
            critical = 15;
          };
          format-time = "{H} ={M =02}";
          format = "{icon} {capacity}% ({time})";
          format-charging = " {capacity}% ({time})";
          format-charging-full = " {capacity}%";
          format-full = "{icon} {capacity}%";
          format-alt = "{icon} {power}W";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = false;
        };

        "clock#time" = {
          interval = 10;
          tooltip = true;
        };

        "clock#date" = {
          interval = 20;
          format = "{:%d.%m.%y}";
          tooltip = false;
        };

        "cpu" = {
          interval = 5;
          tooltip = false;
          format = " {usage}%";
          format-alt = " {load}";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        "disk" = {
          interval = 15;
          format = " {percentage_used}%";
          tooltip = false;
        };

        "memory" = {
          interval = 5;
          format = " {}%";
          states = {
            warning = 70;
            critical = 90;
          };
          tooltip = false;
        };

        "network" = {
          interval = 5;
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ifname}";
          format-disconnected = "No connection";
          format-alt = " {ipaddr}/{cidr}";
          tooltip = false;
        };

        "sway/mode" = {
          format = "{}";
          tooltip = false;
        };

        "sway/window" = {
          format = "{}";
          max-length = 50;
          tooltip = true;
        };

        "sway/workspaces" = {
          disable-scroll-wraparound = true;
          smooth-scrolling-threshold = 4;
          enable-bar-scroll = true;
          format = "{name}";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          scroll-step = 1;
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          tooltip = false;
        };

        "temperature" = {
          critical-threshold = 90;
          interval = 5;
          format = "{icon} {temperatureC}°";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = false;
        };
      };
    };
  };
}
