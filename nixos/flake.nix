{
  description = "NixOS Configuration Flake";

  nixConfig = {
    trusted-substituters = [
      "https://cachix.cachix.org"
      "https://nixpkgs.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

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
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, disko, ... }@inputs:
    let
      system = "x86_64-linux";
      mkNixosConfiguration = name: additionalModules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            ./machines/${name}
            ./machines/${name}/hardware-configuration.nix
            ./machines/${name}/disk-config.nix
            ./configuration.nix
          ] ++ additionalModules;
        };
    in {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-classic;

      nixosConfigurations = {
        darkwings = mkNixosConfiguration "darkwings" [ ./users/chaps ];

        lightwings = mkNixosConfiguration "lightwings" [ ./users/chaps ];

        killua = mkNixosConfiguration "killua" [ ./users/chaps ];
      };
    };
}
