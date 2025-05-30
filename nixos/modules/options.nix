{ lib, ... }:

let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) enum listOf;
in {
  options = {
    audio = {
      enable = mkEnableOption "Weather to enable audio related services";
    };

    browsers = mkOption {
      type = listOf (enum [ "firefox" ]);
      default = [ ];
      description = "The list of browsers to be installed";
    };

    desktopEnvironment = mkOption {
      type = enum [ "none" "river" ];
      default = "none";
      description = "The desktop environment to use if any";
    };

    defaultShell = mkOption {
      type = enum [ "bash" "zsh" ];
      default = "bash";
      description = "The default shell to use";
    };
  };
}
