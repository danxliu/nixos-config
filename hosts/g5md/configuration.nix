{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/core/default.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "g5md";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";

  services.printing.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  services.gnome.gnome-browser-connector.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  users.users.daniel = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };
  programs.tmux = {
    enable = true;
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
      set -g fish_key_bindings fish_vi_key_bindings
    '';
    promptInit = ''
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

  environment.systemPackages = with pkgs; [
    # Themes
    adwaita-icon-theme
    hicolor-icon-theme
    adw-gtk3
    papirus-icon-theme
    quintom-cursor-theme

    nerd-fonts.zed-mono

    git
    wget
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.11";

}

