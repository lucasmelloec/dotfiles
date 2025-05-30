{ lib, ... }:

let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) enum listOf;
in {
  options.user = {
    development = {
      enable = mkEnableOption "Weather to enable development related programs";
    };
  };
}
