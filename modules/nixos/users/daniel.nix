{ pkgs, ... }:

{
  users.users.daniel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    shell = pkgs.fish;
  };
}
