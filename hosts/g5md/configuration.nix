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

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  users.users.daniel = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  environment.systemPackages = with pkgs; [
    git
    wget
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.11";

}

