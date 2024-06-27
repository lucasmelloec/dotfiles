{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    disko = { url = "github:nix-community/disko"; inputs.nixpkgs.follows = "nixpkgs"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };

    ags = { url = "github:Aylur/ags"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprland = { url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; inputs.nixpkgs.follows = "nixpkgs"; };
  };


  outputs = inputs:
  let
    commonModules = [
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.chaps = import ./home.nix;
	home-manager.extraSpecialArgs = { inherit inputs; };
      }
    ];
    in {
    nixosConfigurations.darkwings = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = commonModules ++
        [ 
          ./machines/darkwings/configuration.nix
        ];
    };
  };
}
