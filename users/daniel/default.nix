{ pkgs, inputs, ... }:
let
  fontMonoName = "ZedMono NFM";
  fontUIName = "IBM Plex Sans";
  fontSize = 12;
in
{
  imports = [
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
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = {
    name = "Github Dark";
    palette = {
      base00 = "0d1117";
      base01 = "161b22";
      base02 = "21262d";
      base03 = "89929b";
      base04 = "c6cdd5";
      base05 = "ecf2f8";
      base06 = "fa7970"; # lightred
      base07 = "f84b3e"; # red
      base08 = "faa356"; # yellow
      base09 = "fbb77b"; # lightyellow
      base0A = "a2d2fb"; # lightblue
      base0B = "77bdfb"; # blue
      base0C = "cea5fb"; # lightpurp
      base0D = "b16ef8"; # purp
      base0E = "7ce38b"; # lightgreen
      base0F = "53db67"; # green
    };
  };
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

  gtk = {
    enable = true;
    cursorTheme.name = "Quintom_Ink";
    iconTheme.name = "Papirus";
  };

  dconf.enable = true;
}
