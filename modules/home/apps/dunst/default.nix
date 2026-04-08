{ pkgs, ... }:
{
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    settings = {
      global = {
        follow = "mouse";
        width = "(300, 400)";
        height = 300;
        origin = "top-right";
        offset = "(8, 8)";
        scale = 0;
        notification_limit = 5;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 0;
        icon_corner_radius = 0;
        indicate_hidden = true;
        transparency = 0;
        separator_height = 0;
        padding = 16;
        horizontal_padding = 16;
        text_icon_padding = 16;
        frame_width = 2;
        frame_color = "#f7f7f7";
        gap_size = 0;
        separator_color = "frame";
        sort = true;
        font = "Iosevka Nerd Font Mono 10";
        line_height = 0;
        markup = "full";
        format = ''<span text_transform="capitalize"><b>%s</b></span>\n%b'';
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = true;
        show_indicators = true;
        enable_recursive_icon_lookup = true;
        icon_theme = "Papirus-Light,Adwaita";
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 32;
        icon_path = "/usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/";
        sticky_history = true;
        history_length = 20;
        browser = "${pkgs.xdg-utils}/bin/xdg-open";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 0;
        ignore_dbusclose = false;
        force_xwayland = false;
      };

      urgency_low = {
        background = "#f7f7f7";
        foreground = "#101010";
        timeout = 10;
        default_icon = "dialog-information";
      };

      urgency_normal = {
        background = "#f7f7f7";
        foreground = "#101010";
        timeout = 10;
        override_pause_level = 30;
        default_icon = "dialog-information";
      };

      urgency_critical = {
        background = "#f7f7f7";
        foreground = "#101010";
        frame_color = "#e46876";
        timeout = 0;
        override_pause_level = 60;
        default_icon = "dialog-warning";
      };
    };
  };
}
