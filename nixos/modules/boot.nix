{ inputs, lib, config, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in {
  options.custom = {
    tpm.enable = mkEnableOption "Weather to enable tpm module";
  };
  config = {
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;
      loader.efi.canTouchEfiVariables = true;
      loader.systemd-boot.editor = false;
      loader.systemd-boot.consoleMode = "max";

      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };

      initrd.systemd.enable = mkIf config.custom.tpm.enable true;
    };

    security = mkIf config.custom.tpm.enable {
      tpm2.enable = true;
      tpm2.pkcs11.enable = true;
      tpm2.tctiEnvironment.enable = true;
    };
  };

  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
}
