{ pkgs, ... }:

{
  users.users.daniel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "docker" ];
    shell = pkgs.fish;
  };

  home-manager.users.daniel = import ../../../users/daniel/default.nix;
}
