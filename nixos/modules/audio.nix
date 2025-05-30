{ lib, config, ... }:

let inherit (lib.modules) mkIf;
in {
  config = mkIf config.audio.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
