{ lib, ... }:

let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) nullOr enum path;
in {
  options.custom = {
    gpu = mkOption {
      type = nullOr (enum [ "amd" "nvidia" "nv-amd" ]);
      default = null;
      description = "The GPU configuration";
    };

    nvidia.forceDisable = mkEnableOption "Weather to disable the nvidia card";
  };

  imports = [ ./amd.nix ./nvidia.nix ];
}
