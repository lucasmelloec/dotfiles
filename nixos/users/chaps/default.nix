{ pkgs, lib, config, ... }:

let inherit (lib.modules) mkMerge mkIf;
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chaps = {
    isNormalUser = true;
    extraGroups = mkMerge [
      [ "wheel" "networkmanager" "video" "kvm" ]
      (mkIf config.custom.tpm.enable [ "tss" ])
    ];
    shell = pkgs.zsh;
    packages = [ ];
  };

  nix.settings.trusted-users = [ "chaps" ];

  custom.homeManager.users = [ "chaps" ];
}
