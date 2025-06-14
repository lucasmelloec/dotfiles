{ lib, ... }:

let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum listOf;
in {
  options.custom = {
    browsers = mkOption {
      type = listOf (enum [ "firefox" ]);
      default = [ ];
      description = "The list of browsers to be installed";
    };
  };

  imports = [ ./firefox.nix ];
}
