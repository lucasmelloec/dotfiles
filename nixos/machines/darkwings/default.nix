{ inputs, ... }:

{
  imports = with inputs; [
    disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disk-config.nix
    ../../configuration.nix
    ../../roles/laptop.nix
  ];

  # Options
  custom.audio.enable = true;
  custom.browsers = [ "firefox" ];
  custom.desktopEnvironment = "river";
  custom.defaultShell = "zsh";
  custom.homeManager.enable = true;
  custom.gpu = "nv-amd";
  custom.nvidia.forceDisable = true;

  networking.hostName = "darkwings";
}
