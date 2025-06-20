{ inputs, lib, ... }:

{
  boot = {
    loader.systemd-boot.enable = lib.mkForce false;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.editor = false;
    loader.systemd-boot.consoleMode = "max";

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
}
