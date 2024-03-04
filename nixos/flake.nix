{
  description = "NixOS Configuration Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, auto-cpufreq, ... }@inputs:
    let
      commonModules = [
        inputs.disko.nixosModules.disko
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.chaps = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit inputs nixpkgs; };
        }
      ];
      system = "x86_64-linux";
    in {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-classic;
      nixosConfigurations.darkwings = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = commonModules ++ [
          ./machines/darkwings/configuration.nix
          auto-cpufreq.nixosModules.default
        ];
      };
    };
}
