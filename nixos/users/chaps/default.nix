{ nixpkgs, pkgs, inputs, ... }:

{
  imports = with inputs; [
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.chaps = import ./home.nix;
      home-manager.extraSpecialArgs = { inherit inputs nixpkgs; };
    }
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chaps = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "kvm" ];
    shell = pkgs.zsh;
    packages = [ ];
  };

  nix.settings.trusted-users = [ "chaps" ];
}
