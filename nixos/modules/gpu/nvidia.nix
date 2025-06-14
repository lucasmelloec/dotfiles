{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
  usesNvidia = [ "nvidia" "nv-amd" ];
in {
  config = mkIf (builtins.elem config.custom.gpu usesNvidia) {
    # Disable nvidia
    boot = mkIf config.custom.nvidia.forceDisable {
      extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
      '';
      blacklistedKernelModules =
        [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
    };
  };
}
