{ pkgs, config, lib, ... }:

let inherit (lib.modules) mkIf;
in {
  config = mkIf (config.custom.desktopEnvironment == "river") {
    custom.wayland.enable = true;

    environment.systemPackages = with pkgs; [ waybar wlogout ];

    programs.river = { enable = true; };

    environment.sessionVariables = {
      QT_IM_MODULE = "fcitx";
      # XMODIFIERS = "@im=fcitx";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_DRM_DEVICES = config.custom.amd.card;
    };
  };
}
