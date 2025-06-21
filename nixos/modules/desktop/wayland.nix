{ pkgs, config, lib, ... }:

let inherit (lib.modules) mkIf;
in {
  config = mkIf config.custom.wayland.enable {
    environment.systemPackages = with pkgs; [ wl-clipboard fuzzel ];

    # Enable SDDM
    services.displayManager.sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };

    environment.sessionVariables = {
      KWIN_DRM_DEVICES = config.custom.amd.card;
    };
  };
}
