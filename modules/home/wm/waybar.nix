{ pkgs, ... }: {
  home.packages = [
    pkgs.jetbrains-mono
  ];
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
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
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
          format = "  {usage}%";
          format-alt = "  {load}";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        "disk" = {
          interval = 15;
          format = " {percentage_used}%";
        };

        "memory" = {
          interval = 5;
          format = " {}%";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        "network" = {
          interval = 5;
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = "󰈁 {ifname}";
          format-disconnected = "No connection";
          format-alt = "󰛳 {ipaddr}/{cidr}";
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
          format = "{icon} {volume}%";
          format-bluetooth = "{icon}  {volume}%";
          format-muted = "";
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
        };

        "sway/language" = {
          format = "{}";
          on-click = "swaymsg input type:keyboard xkb_switch_layout next";
        };
      };
    };
  };
}
