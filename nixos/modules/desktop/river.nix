{ pkgs, config, lib, ... }:

let inherit (lib.modules) mkIf;
in {
  config = mkIf (config.desktopEnvironment == "river") {
    wayland.enable = true;

    environment.systemPackages = with pkgs; [ waybar wlogout ];

    programs.river = { enable = true; };
  };
}
