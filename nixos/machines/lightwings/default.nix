{ inputs, lib, config, ... }:

let inherit (lib.modules) mkIf;
in {
  imports = with inputs; [
    disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disko-config.nix
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
  custom.nvidia.forceDisable = true;
  custom.amd.card = "/dev/dri/by-path/pci-0000:11:00.0-card";

  networking.hostName = "lightwings";

  hardware.display = mkIf config.custom.nvidia.forceDisable {
    outputs."HDMI-A-1".mode = "e";
    outputs."Unknown-1".mode = "d";
  };
}
