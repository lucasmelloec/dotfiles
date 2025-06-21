{ lib, config, ... }:

let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.types) enum nullOr;
in {
  options.custom = {
    desktopEnvironment = mkOption {
      type = nullOr (enum [ "river" ]);
      default = null;
      description = "The desktop environment to use if any";
    };
    wayland.enable = mkEnableOption "Wheather to use wayland or not";
  };

  imports = [ ./wayland.nix ./river.nix ];
}
