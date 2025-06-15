{ lib, config, pkgs, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in {
  options.custom = {
    gui.enable = mkEnableOption "Wheater to enable GUI application";
  };

  config = mkIf (config.custom.desktopEnvironment != null) {
    custom.gui.enable = true;
    environment.systemPackages = with pkgs; [ xfce.thunar ];
  };
}
