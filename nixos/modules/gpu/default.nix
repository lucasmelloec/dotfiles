{ lib, ... }:

let
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr enum bool;
in {
  options = {
    gpu = {
      type = mkOption {
        type = nullOr (enum [ "amd" "nvidia" "nv-amd" ]);
        default = null;
        description = "The GPU configuration";
      };
      nvidia.enable = mkOption {
        type = bool;
        default = true;
        description = "Weather to enable the nvidia card";
      };
    };
  };

  imports = [ ./amd.nix ./nvidia.nix ];
}
