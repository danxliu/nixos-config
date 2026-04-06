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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = true;
    nvidiaSettings = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.printing.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  services.gnome.gnome-browser-connector.enable = true;
  services.openssh.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.libinput.enable = true;
  services.tailscale.enable = true;

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

  programs.nix-index.enable = true;
  programs.nix-index.enableFishIntegration = true;
  programs.nix-index-database.comma.enable = true;

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
    devenv
  ];
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    NIXOS_OZONE_WL = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  system.stateVersion = "25.11";

}
