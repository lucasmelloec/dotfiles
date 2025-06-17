{ lib, ... }:

let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) nullOr enum path bool str;
in {
  options.custom = {
    gpu = mkOption {
      type = nullOr (enum [ "amd" "nvidia" "nv-amd" ]);
      default = null;
      description = "The GPU configuration";
    };

    nvidia = {
      specialisation = mkEnableOption
        "Weather to create a split boot entry for nvidia-enabled";
      open = mkOption {
        type = bool;
        default = true;
        description = "Weather to use new open source drivers";
      };
      busId = mkOption {
        type = str;
        default = "";
        description = "Bus ID to be used with Optimus Prime";
      };
    };

    amd = {
      card = mkOption {
        type = nullOr (path);
        default = null;
        description = "Path to the amd video card";
      };
      busId = mkOption {
        type = str;
        default = "";
        description = "Bus ID to be used with Optimus Prime";
      };
    };
  };

  imports = [ ./amd.nix ./nvidia.nix ];
}
