{ lib, config, ... }:

let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
in {
  options.custom = {
    ssh.enable = mkEnableOption "Weather to enable ssh server";
  };

  config = mkIf config.custom.ssh.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        X11Forwarding = false;
        PermitRootLogin = "no";
      };
    };
  };
}
