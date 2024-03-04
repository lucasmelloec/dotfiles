{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../common.nix
    ../../modes/laptop.nix
  ];

  networking.hostName = "darkwings";

  # AMD GPU
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = lib.mkForce [ "amdgpu" ];

  # Disable nvidia
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';
  boot.blacklistedKernelModules =
    [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
}
