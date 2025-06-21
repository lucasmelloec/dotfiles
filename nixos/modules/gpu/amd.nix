{ lib, config, ... }:

let
  inherit (lib.modules) mkIf mkForce;
  usesAmd = [ "amd" "nv-amd" ];
in {
  config = mkIf (builtins.elem config.gpu.type usesAmd) {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver =
      mkIf (!config.gpu.nvidia.enable) { videoDrivers = mkForce [ "amdgpu" ]; };
  };
}
