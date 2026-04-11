{ lib, pkgs, ... }:

{
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];

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
}
