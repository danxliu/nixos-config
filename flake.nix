{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nur,
      ...
    }@inputs:
    let
      getSubDirs =
        dir:
        builtins.attrNames (
          nixpkgs.lib.filterAttrs (name: type: type == "directory") (builtins.readDir dir)
        );

      hosts = getSubDirs ./hosts;
      users = getSubDirs ./users;

      userConfigs = builtins.listToAttrs (
        map (user: {
          name = user;
          value = import ./users/${user}/home.nix;
        }) users
      );

      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              (
                { pkgs, ... }:
                {
                  nixpkgs.overlays = [ nur.overlays.default ];
                }
              )
              ./hosts/${host}/configuration.nix
              inputs.nix-index-database.nixosModules.nix-index
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                };
                home-manager.sharedModules = [
                  inputs.nix-index-database.homeModules.nix-index
                ];
                home-manager.users.daniel = import ./users/daniel/home.nix;
              }
            ];
          };
        }) hosts
      );
    in
    {
      inherit nixosConfigurations;
    };
}
