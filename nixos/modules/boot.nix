{ inputs, lib, ... }:

{
  boot = {
    loader.systemd-boot.enable = lib.mkForce false;
    loader.efi.canTouchEfiVariables = true;

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
}
