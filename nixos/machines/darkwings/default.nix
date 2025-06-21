{ lib, inputs, ... }:

{
  imports = with inputs; [
    disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disk-config.nix
    ../../configuration.nix
    ../../roles/laptop.nix
  ];

  # Options
  audio.enable = true;
  browsers = [ "firefox" ];
  desktopEnvironment = "river";
  defaultShell = "zsh";
  homeManager.enable = true;
  gpu.type = "nv-amd";
  gpu.nvidia.enable = false;

  networking.hostName = "darkwings";
}
