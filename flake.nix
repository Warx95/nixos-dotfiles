{
  description = "NixOS multi-host flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
  let
    # Helper function to generate host configurations
    mkHost = hostName: system: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/${hostName}/configuration.nix
        {
          nixpkgs.config.allowUnfree = true;
          networking.hostName = hostName;
        }
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.rusantokhin = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  in {
    nixosConfigurations = {
      home-desktop   = mkHost "home-desktop"   "x86_64-linux";
      office-desktop = mkHost "office-desktop" "x86_64-linux";
      laptop         = mkHost "laptop"         "x86_64-linux";
    };
  };
}
