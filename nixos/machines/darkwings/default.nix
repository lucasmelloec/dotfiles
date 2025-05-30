{ lib, inputs, ... }:

{
  imports = with inputs; [
    disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../roles/laptop.nix
  ];

  # Options
  audio.enable = true;
  browsers = [ "firefox" ];
  desktopEnvironment = "river";
  defaultShell = "zsh";

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
