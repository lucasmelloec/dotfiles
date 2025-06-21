{ lib, ... }:

let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum;
in {
  options.custom = {
    defaultShell = mkOption {
      type = enum [ "bash" "zsh" ];
      default = "bash";
      description = "The default shell to use";
    };
  };

  imports = [ ./zsh.nix ];

  config = {
    environment.sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
    };
  };
}
