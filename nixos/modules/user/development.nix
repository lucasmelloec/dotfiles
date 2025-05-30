{ pkgs, lib, config, ... }:

let inherit (lib.modules) mkIf;
in {
  config = mkIf config.user.development.enable {
    home.packages = with pkgs; [ tmux gnumake jujutsu gcc ];

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.zoxide.enable = true;
  };
}
