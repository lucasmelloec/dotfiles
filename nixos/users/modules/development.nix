{ pkgs, lib, config, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in {
  options.user = {
    development.enable =
      mkEnableOption "Weather to enable development related programs";
  };

  config = mkIf config.user.development.enable {
    home.packages = with pkgs; [ tmux gnumake jujutsu gcc nil lazygit ];

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.zoxide.enable = true;
  };
}
