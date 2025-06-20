{ inputs, ... }:

{
  imports = with inputs; [
    disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disk-config.nix
    ../../configuration.nix
    ../../roles/desktop.nix
  ];

  # Options
  custom.audio.enable = true;
  custom.browsers = [ "firefox" ];
  custom.desktopEnvironment = "river";
  custom.defaultShell = "zsh";
  custom.homeManager.enable = true;
  custom.gpu = "nv-amd";
  custom.amd.card = "/dev/dri/card1";
  custom.amd.busId = "PCI:11:0:0";
  custom.nvidia.busId = "PCI:1:0:0";
  custom.tpm.enable = true;

  networking.hostName = "lightwings";

  hardware.display = {
    outputs."HDMI-A-1".mode = "e";
    outputs."Unknown-1".mode = "d";
  };
}
