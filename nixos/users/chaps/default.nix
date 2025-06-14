{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chaps = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "kvm" ];
    shell = pkgs.zsh;
    packages = [ ];
  };

  nix.settings.trusted-users = [ "chaps" ];

  custom.homeManager.users = [ "chaps" ];
}
