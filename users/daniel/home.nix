{
  config,
  pkgs,
  lib,
  ...
}:
let
  gtkThemeLight = "adw-gtk3";
  gtkThemeDark = "adw-gtk3-dark";
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
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  services.dunst.enable = true;
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
    style = ./waybar/style.css;
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
  programs.wofi = {
    enable = true;
    settings = {
      width = 500;
      height = 250;
      no_actions = true;
      allow_images = true;
      image_size = 32;
      hide_scroll = true;
    };
    style = ./wofi/style.css;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/nvim-treesitter.lua;
      }
      {
        plugin = luasnip;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/luasnip.lua;
      }
      nvim-lspconfig
      {
        plugin = blink-cmp;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/blink-cmp.lua;
      }
      {
        plugin = mini-pick;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/mini-pick.lua;
      }
      nvim-web-devicons
      {
        plugin = dashboard-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/dashboard.lua;
      }
      {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/colorizer.lua;
      }
      vimtex
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/lualine.lua;
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/nvim-tree.lua;
      }
      github-nvim-theme
    ];
    initLua = builtins.readFile ./nvim/init.lua;
  };

  home.packages = with pkgs; [
    vesktop
    trayscale

    # LSPs
    clang-tools
    pyright
    jdt-language-server
    typescript-language-server
    vscode-langservers-extracted
    rust-analyzer
    nil
    marksman
    texlab

    gemini-cli
    github-copilot-cli
    ripgrep
    tree
    awww
    hyprlock
    thunar
    xbacklight
    zathura
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

  xdg = {
    configFile = {
      "dunst/dunstrc".source = ./dunst/dunstrc;
      "niri/config.kdl".source = ./niri/config.kdl;
      "nvim/snippets/package.json".source = ./nvim/snippets/package.json;
      "nvim/snippets/cpp.json".source = ./nvim/snippets/cpp.json;
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
  };

  gtk = {
    enable = true;
    cursorTheme.name = cursorTheme;
    iconTheme.name = iconTheme;
  };
  dconf.enable = true;
}
