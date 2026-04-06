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
  programs.fish.enable = true;

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
    comma
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.11";

}

