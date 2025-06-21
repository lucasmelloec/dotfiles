{ lib, config, ... }:

let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
in {
  options.custom = {
    audio.enable = mkEnableOption "Weather to enable audio related services";
  };

  config = mkIf config.custom.audio.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
