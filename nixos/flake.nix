{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:Aylur/ags";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };


  outputs = { self, nixpkgs, disko, home-manager, ...}@inputs:
  let
    commonModules = [
      disko.nixosModules.disko
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.chaps = import ./home.nix;
	home-manager.extraSpecialArgs = { inherit inputs; };
      }
    ];
    in {
    nixosConfigurations.darkwings = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = commonModules ++
        [ 
          ./machines/darkwings/configuration.nix
        ];
    };
  };
}
