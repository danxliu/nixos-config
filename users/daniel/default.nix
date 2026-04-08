{ pkgs, config, inputs, theme, ... }:
let
  fontMonoName = "ZedMono NFM";
  fontUIName = "IBM Plex Sans";
  fontSize = 12;
in
{
  imports = [
    ../../modules/home/theme
    ../../modules/home/apps/alacritty
    ../../modules/home/apps/firefox
    ../../modules/home/apps/fish
    ../../modules/home/apps/dunst
    ../../modules/home/apps/neovim
    ../../modules/home/apps/tmux
    ../../modules/home/apps/vscode
    ../../modules/home/apps/waybar
    ../../modules/home/apps/wofi
    ../../modules/home/apps/zed
    ../../modules/home/desktop/xdg.nix
    ../../modules/home/services/session.nix
  ];
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

  apps.dunst = {
    iconTheme = "Papirus";
    font = {
      name = fontUIName;
      size = fontSize;
    };
  };
  apps.alacritty = {
    font = {
      name = fontMonoName;
      size = fontSize;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.htop.enable = true;
  programs.obsidian.enable = true;

  home.packages = with pkgs; [
    vesktop
    trayscale

    clang-tools
    pyright
    jdt-language-server
    typescript-language-server
    vscode-langservers-extracted
    rust-analyzer
    nil
    nixd
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
}
