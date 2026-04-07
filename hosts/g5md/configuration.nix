{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/default.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
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
    open = false;
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
  services.xserver.videoDrivers = [ "nvidia" ];
  programs.niri.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.tuigreet} --time --remember --remember-user-session --cmd niri-session";
        user = "greeter";
      };
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

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
  programs.tmux = {
    enable = true;
  };
  programs.fish.enable = true;

  programs.nix-index.enable = true;
  programs.nix-index.enableFishIntegration = true;
  programs.nix-index-database.comma.enable = true;
  programs.nix-ld.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.zed-mono
    nerd-fonts.iosevka
  ];

  environment.systemPackages = with pkgs; [
    gtk3
    gtk3.dev

    # Themes
    adwaita-icon-theme
    hicolor-icon-theme
    adw-gtk3
    papirus-icon-theme
    quintom-cursor-theme

    pavucontrol
    alacritty

    jdk21
    nodejs_24
    nodejs_20

    unzip
    git
    wget
    devenv
  ];
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

  system.stateVersion = "25.11";
}
