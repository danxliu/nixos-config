{ pkgs, ... }:
let
  gtkThemeLight = "adw-gtk3";
  gtkThemeDark = "adw-gtk3-dark";
in
{
  systemd.user.services.awww = {
    Unit = {
      Description = "Awww Wallpaper Daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.awww}/bin/awww-daemon";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services.themeSync = {
    Unit = {
      Description = "Sync GTK3 theme";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart =
        let
          themeSyncScript = pkgs.writeShellScript "theme-sync.sh" ''
            set_theme() {
              CURRENT_THEME=$(${pkgs.glib}/bin/gsettings get org.gnome.desktop.interface color-scheme)
              if [ "$CURRENT_THEME" = "'prefer-dark'" ]; then
                ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme \'${gtkThemeDark}\'
                ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme \'prefer-dark\'
              else
                ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme \'${gtkThemeLight}\'
                ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme \'default\'
              fi
            }
            set_theme
            ${pkgs.dconf}/bin/dconf watch /org/gnome/desktop/interface/color-scheme | while read -r _; do
              set_theme
            done
          '';
        in
        "${themeSyncScript}";
      Restart = "on-failure";
    };
  };
}
