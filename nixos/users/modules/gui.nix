{ pkgs, lib, osConfig, ... }:

let inherit (lib.modules) mkIf;
in {
  config = mkIf osConfig.custom.gui.enable {
    home.packages = with pkgs; [ alacritty ];
  };
}
