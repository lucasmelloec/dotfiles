{ inputs, ... }:

{
  imports = with inputs; [
    disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../configuration.nix
    ../../roles/desktop.nix
  ];

  # Options
  audio.enable = true;
  browsers = [ "firefox" ];
  desktopEnvironment = "river";
  defaultShell = "zsh";
  homeManager.enable = true;
  gpu.type = "nv-amd";
  gpu.nvidia.enable = false;

  networking.hostName = "lightwings";
}
