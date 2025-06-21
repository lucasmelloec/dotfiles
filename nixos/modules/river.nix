{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ waybar wl-clipboard ];

  programs.river = { enable = true; };

  # Enable SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
}
