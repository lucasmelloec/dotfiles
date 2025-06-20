{ inputs, ... }:

{
  imports = with inputs; [ ../../roles/laptop.nix ];

  # Options
  custom.audio.enable = true;
  custom.browsers = [ "firefox" ];
  custom.desktopEnvironment = "river";
  custom.defaultShell = "zsh";
  custom.homeManager.enable = true;
  custom.gpu = "nv-amd";
  custom.amd.card = "/dev/dri/card1";
  custom.amd.busId = "PCI:5:0:0";
  custom.nvidia.busId = "PCI:1:0:0";
  custom.nvidia.specialisation = true;

  networking.hostName = "darkwings";
}
