{ pkgs, lib, config, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in {
  options.user = {
    messaging.enable = mkEnableOption "Weather to enable messaging apps";
  };

  config = mkIf (config.user.gui.enable && config.user.messaging.enable) {
    home.packages = with pkgs; [ _1password-gui telegram-desktop discord ];
  };
}
