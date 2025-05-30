{ config, lib, ... }:

let inherit (lib.modules) mkIf;
in {
  config = mkIf (config.defaultShell == "zsh") {
    programs.zsh.enable = true;

    # For zsh autocompletion to work
    environment.pathsToLink = [ "/share/zsh" ];
  };
}
