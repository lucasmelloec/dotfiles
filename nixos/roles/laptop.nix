{ inputs, ... }:

{
  imports = [ inputs.auto-cpufreq.nixosModules.default ];
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  programs.auto-cpufreq.enable = true;
}
