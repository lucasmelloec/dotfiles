{ pkgs, config, lib, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in {
  options = {
    wayland.enable = mkEnableOption "Wheather to use wayland or not";
  };

  config = mkIf config.wayland.enable {
    environment.systemPackages = with pkgs; [ wl-clipboard fuzzel ];

    # Enable SDDM
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
