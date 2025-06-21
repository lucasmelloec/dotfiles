{ pkgs, config, lib, ... }:

let inherit (lib.modules) mkIf;
in {
  config = mkIf (config.custom.desktopEnvironment == "river") {
    custom.wayland.enable = true;

    environment.systemPackages = with pkgs; [ waybar wlogout ];

    programs.river = { enable = true; };
  };
}
