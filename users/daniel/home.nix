{ config, pkgs, ... }:
let
  gtkTheme = "adw-gtk3";
  iconTheme = "Papirus";
  cursorTheme = "Quintom_Ink";
in {
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
      };
      search.engines = {
        nix-packages = {
          name = "Nix Packages";
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };

        nixos-wiki = {
          name = "NixOS Wiki";
          urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
          iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
          definedAliases = [ "@nw" ];
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
      settings = {
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
      ];
      userSettings = builtins.fromJSON (builtins.readFile ./vscode-settings.json);
    };
  };
  programs.htop = {
    enable = true;
  };
  programs.fish = {
    enable = true;
  };

  home.packages = with pkgs; [
    alacritty
    gemini-cli-bin
    vesktop

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
    
    ripgrep
    tree
  ];

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
    cursorTheme.name = cursorTheme;
    theme.name = gtkTheme;
    iconTheme.name = iconTheme;
  };
}
