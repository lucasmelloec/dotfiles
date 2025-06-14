{ pkgs, lib, config, osConfig, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in {
  options.user = {
    gui.enable = mkEnableOption "Weather to enable GUI applications";
  };

  config = mkIf (osConfig.desktopEnvironment != null) {
    user.gui.enable = true;

    home.packages = with pkgs; [ alacritty ];
  };
}
