{
  theme, ...
}:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        reload_style_on_change = true;
        modules-left = [
          "niri/workspaces"
          "custom/separator"
          "niri/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "custom/separator"
          "network"
          "custom/separator"
          "battery"
          "custom/separator"
          "pulseaudio"
        ];

        "niri/workspaces" = {
          format = "{value}";
        };

        "niri/window" = {
          format = "{app_id}";
          icon = true;
          rewrite = {
            "^(.*)$" = "<span text_transform='capitalize'>$1</span>";
          };
        };

        "custom/separator" = {
          format = "|";
        };

        clock = {
          timezone = "America/Los_Angeles";
          format = "{:%I:%M %p}";
          tooltip-format = "{:%A, %B %d %Y}";
        };

        battery = {
          format = "BAT: {capacity}%";
          tooltip-format = "BAT: {capacity}%";
          format-charging = "BAT: {capacity}%+";
          tooltip-format-charging = "BAT: {capacity}%+";
        };

        network = {
          format-wifi = "WIFI: {essid}";
          tooltip-format-wifi = "WIFI: {essid}";
          format-ethernet = "ETH: {ifname}";
          tooltip-format-ethernet = "ETH: {ifname}";
          format-disconnected = "WIFI: DISCONNECTED";
          tooltip-format-disconnected = "DISCONNECTED";
        };

        pulseaudio = {
          format = "VOL: {volume}%";
          format-muted = "[VOL: MUTED]";
          tooltip-format = "VOL: {volume}%";
          tooltip-format-muted = "MUTED";
        };

        tray = {
          icon-size = 14;
          spacing = 6;
        };
      };
    };
    style = theme.replaceText (builtins.readFile ./style.css);
  };
}
