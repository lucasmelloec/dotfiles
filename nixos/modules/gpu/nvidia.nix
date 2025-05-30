{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
  usesNvidia = [ "nvidia" "nv-amd" ];
in {
  config = mkIf (builtins.elem config.gpu.type usesNvidia) {
    # Disable nvidia
    boot = mkIf (!config.gpu.nvidia.enable) {
      extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
      '';
      blacklistedKernelModules =
        [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
    };
  };
}
