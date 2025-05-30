{ pkgs, config, lib, ... }:

let inherit (lib.modules) mkIf;
in {
  config = mkIf (config.desktopEnvironment == "river") {
    environment.systemPackages = with pkgs; [ waybar wlogout ];

    programs.river = { enable = true; };
  };
}
