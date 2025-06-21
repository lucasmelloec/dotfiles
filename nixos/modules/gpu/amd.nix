{ lib, config, pkgs, ... }:

let
  inherit (lib.modules) mkIf mkForce;
  usesAmd = [ "amd" "nv-amd" ];
in {
  config = mkIf (builtins.elem config.custom.gpu usesAmd) {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = mkForce [ "amdgpu" ];
    hardware.graphics.extraPackages = with pkgs; [ amdvlk ];
  };
}
