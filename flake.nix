{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      getSubDirs = dir: builtins.attrNames (nixpkgs.lib.filterAttrs (name: type: type == "directory") (builtins.readDir dir));

      hosts = getSubDirs ./hosts;
      users = getSubDirs ./users;

      userConfigs = builtins.listToAttrs (map (user: {
        name = user;
        value = import ./users/${user}/home.nix;
      }) users);

      nixosConfigurations = builtins.listToAttrs (map (host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/${host}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users = userConfigs;
            }
          ];
        };
      }) hosts);
    in {
      inherit nixosConfigurations;
    };
}
