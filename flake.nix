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

  outputs = inputs@{ nixpkgs, home-manager, nur, ... }:
    let
      lib = nixpkgs.lib;

      getSubDirs =
        dir:
        lib.attrNames (
          lib.filterAttrs (_: type: type == "directory") (builtins.readDir dir)
        );

      hosts = getSubDirs ./hosts;
      users = builtins.filter (user: builtins.pathExists (./users + "/${user}/default.nix")) (getSubDirs ./users);

      homeUsers = lib.genAttrs users (user: import (./users + "/${user}/default.nix"));

      homeManagerModule = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs; };
          sharedModules = [
            inputs.nix-index-database.homeModules.nix-index
          ];
          users = homeUsers;
        };
      };

      mkHost =
        host:
        lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ({ ... }: { nixpkgs.overlays = [ nur.overlays.default ]; })
            ./hosts/${host}/configuration.nix
            inputs.nix-index-database.nixosModules.nix-index
            home-manager.nixosModules.home-manager
            homeManagerModule
          ];
        };
    in
    {
      nixosConfigurations = lib.genAttrs hosts mkHost;
    };
}
