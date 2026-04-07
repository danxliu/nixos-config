{ pkgs, ... }:

{
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
}
