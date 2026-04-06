{
  config,
  pkgs,
  lib,
  ...
}:
let
  gtkTheme = "adw-gtk3";
  iconTheme = "Papirus";
  cursorTheme = "Quintom_Ink";
in
{
  home.username = "daniel";
  home.homeDirectory = "/home/daniel";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Daniel Liu";
        email = "danxliu@protonmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxAccounts = false;
      FirefoxHome = {
        Search = true;
        TopSites = true;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
    profiles.default = {
      isDefault = true;
      settings = {
        "browser.startup.homepage" = "https://danxliu.com/startpage";
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.startup.page" = 3;
        "browser.sessionstore.resume_from_crash" = true;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.ctrlTab.previews" = true;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "browser.urlbar.suggest.recentsearches" = false;
        "dom.battery.enabled" = false;
      };
      search.engines = {
        nix-packages = {
          name = "Nix Packages";
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };

        nixos-wiki = {
          name = "NixOS Wiki";
          urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
          icon = "https://wiki.nixos.org/favicon.ico";
          definedAliases = [ "@nw" ];
        };
        home-manager-options = {
          name = "HomeManager Options";
          urls = [
            { template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master"; }
          ];
          icon = "https://wiki.nixos.org/favicon.ico";
          definedAliases = [ "@hm" ];
        };
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        #https://github.com/nix-community/nur-combined/blob/main/repos/rycee/pkgs/firefox-addons/addons.json
        clearurls
        csgo-trader-steam-trading
        csgofloat
        dont-track-me-google1
        multi-account-containers
        frankerfacez
        gnome-shell-integration
        localcdn
        proton-pass
        return-youtube-dislikes
        sponsorblock
        steam-database
        tampermonkey
        ublock-origin
        youtube-shorts-block
      ];
    };
  };
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        github.github-vscode-theme
        pkief.material-icon-theme
        vscodevim.vim
        esbenp.prettier-vscode
        ms-python.python
        vscjava.vscode-java-pack
        bbenoist.nix
        Google.gemini-cli-vscode-ide-companion
        ms-toolsai.jupyter
      ];
      userSettings = builtins.fromJSON (builtins.readFile ./vscode-settings.json);
    };
  };
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    shortcut = "Space";
    shell = "${pkgs.fish}/bin/fish";

    extraConfig = ''
      # Options
      set-option -g allow-rename off

      # Status Bar
      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'fg=blue'
      setw -g mode-style 'fg=black bg=color15'
      set -g status-right-style 'fg=black bg=color15'
      set -g status-right ' %Y-%m-%d %H:%M %p '
      setw -g window-status-current-style 'fg=black bg=color15'
      setw -g window-status-current-format ' #I #W '
      set -g message-style 'fg=black bg=red bold'

      # Mappings
      # Note: Home Manager places the config in ~/.config/tmux/tmux.conf
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

      bind h select-pane -L
      bind l select-pane -R
      bind k select-pane -U
      bind j select-pane -D

      bind C-h resize-pane -L 10
      bind C-l resize-pane -R 10
      bind C-k resize-pane -U 10
      bind C-j resize-pane -D 10

      bind Tab next-window
      bind BTab previous-window
      bind t new-window
    '';
  };
  programs.htop = {
    enable = true;
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
      set -g fish_key_bindings fish_vi_key_bindings

      function fish_prompt
        set_color black -b brwhite
        echo -n " 󰘧 "
        set_color normal
        echo -n " "
        # Note: Added a space before the parenthesis here for proper fish syntax
        printf '%s' (prompt_pwd --full-length-dirs 2)
        echo -n " "
      end

      function fish_right_prompt
        set -l git_status (fish_git_prompt)
        set -l duration "$CMD_DURATION"

        if test -n "$git_status"
          echo -n "$git_status "
        end

        if test -n "$duration"
          set_color black -b brwhite
          echo -n " $duration"
          echo -n "ms "
        end
        set_color normal
      end

      function fish_mode_prompt
        commandline -f repaint
      end
    '';
  };
  programs.alacritty = {
    enable = true;
    settings = {
      general.live_config_reload = true;
      window.padding = {
        x = 20;
        y = 20;
      };
      font = {
        normal.family = "ZedMono NFM";
        size = 12;
        offset = {
          y = 8;
        };
        glyph_offset = {
          y = 4;
        };
      };
      terminal.shell.program = "tmux";
    };
    theme = "github_dark_default"; # https://github.com/alacritty/alacritty-theme/tree/master/themes
  };
  programs.zed-editor = {
    enable = true;
    userSettings = builtins.fromJSON (builtins.readFile ./zed-settings.json);
  };
  programs.obsidian = {
    enable = true;
  };

  home.packages = with pkgs; [
    vesktop
    trayscale

    # Gnome extensions
    gnome-extension-manager
    gnome-tweaks
    gnomeExtensions.just-perfection
    gnomeExtensions.dash-to-dock
    gnomeExtensions.media-controls
    gnomeExtensions.caffeine
    gnomeExtensions.user-themes
    gnomeExtensions.gsconnect
    gnomeExtensions.appindicator

    gemini-cli
    github-copilot-cli
    ripgrep
    tree
  ];

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
                ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme \'adw-gtk3-dark\'
                ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme \'prefer-dark\'
              else
                ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme \'adw-gtk3\'
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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  gtk = {
    enable = true;
    theme.name = gtkTheme;
    cursorTheme.name = cursorTheme;
    iconTheme.name = iconTheme;
    gtk4.theme = config.gtk.theme;
  };
  dconf.enable = true;
}
