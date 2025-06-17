{ inputs, ... }:

{
  imports = [ ];
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  powerManagement.enable = true;
  services.tlp.enable = true;
  services.auto-cpufreq.enable = true;
}
