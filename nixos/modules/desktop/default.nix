{ lib, ... }:

let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum nullOr;
in {
  options = {
    desktopEnvironment = mkOption {
      type = nullOr (enum [ "river" ]);
      default = null;
      description = "The desktop environment to use if any";
    };
  };

  imports = [ ./wayland.nix ./river.nix ];
}
