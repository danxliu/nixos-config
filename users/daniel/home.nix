{ config, pkgs, ... }:
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

  programs.firefox = {
    enable = true;
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
      };
    };
  };

  programs.vscode = {
    enable = true;
  };
  programs.htop = {
    enable = true;
  };

  home.packages = with pkgs; [
    alacritty
    gemini-cli-bin
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
}
