{ pkgs, config, lib, ... }:

let
  inherit (lib.modules) mkIf;
  waylandDesktopEnvironments = [ "river" ];
in {
  config =
    mkIf (builtins.elem config.desktopEnvironment waylandDesktopEnvironments) {
      environment.systemPackages = with pkgs; [ wl-clipboard fuzzel ];

      # Enable SDDM
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
}
