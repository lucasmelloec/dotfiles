{ nixpkgs, inputs, lib, config, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) str listOf;
  inherit (lib.attrsets) genAttrs;
in {
  options.custom = {
    homeManager = {
      enable = mkEnableOption "Weather to use home-manager";
      users = mkOption {
        type = listOf str;
        default = [ ];
        description = "List of users to enable home-manager in";
      };
    };
  };

  config = {
    home-manager = mkIf config.custom.homeManager.enable {
      useGlobalPkgs = true;
      useUserPackages = true;
      users =
        genAttrs config.custom.homeManager.users (name: ./${name} + /home.nix);
      extraSpecialArgs = { inherit inputs nixpkgs; };
    };
  };

  imports = [ inputs.home-manager.nixosModules.home-manager ];
}
