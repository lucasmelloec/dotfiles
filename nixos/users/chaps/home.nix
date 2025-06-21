{ config, pkgs, lib, ... }:

let
  homeDirectory = "/home/chaps";
  dotfiles = "${homeDirectory}/dotfiles";
in {
  imports = [ ../modules ];
  home.username = "chaps";
  home.homeDirectory = homeDirectory;

  home.packages = [ ];

  # User Options
  user = {
    development.enable = true;
    messaging.enable = true;
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "exa --icons=auto";
      update-system = "sudo nixos-rebuild switch --flake .";
    };
  };

  programs.starship.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.configFile = {
    tmux = {
      source =
        config.lib.file.mkOutOfStoreSymlink "${dotfiles}/tmux/.config/tmux";
    };
    fuzzel = {
      source =
        config.lib.file.mkOutOfStoreSymlink "${dotfiles}/fuzzel/.config/fuzzel";
    };
    git = {
      source =
        config.lib.file.mkOutOfStoreSymlink "${dotfiles}/git/.config/git";
    };
    starship = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${homeDirectory}/dotfiles/starship/.config/starship";
    };
    alacritty = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${homeDirectory}/dotfiles/alacritty/.config/alacritty";
    };
    nvim = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${homeDirectory}/dotfiles/nvim/.config/nvim";
    };
    river = {
      source =
        config.lib.file.mkOutOfStoreSymlink "${dotfiles}/river/.config/river";
    };
    waybar = {
      source =
        config.lib.file.mkOutOfStoreSymlink "${dotfiles}/waybar/.config/waybar";
    };
  };

  home.activation.install-tmux-tpm =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if ! [ -d "${config.xdg.configHome}/tmux/plugins/tpm" ]; then
        run ${pkgs.git}/bin/git clone $VERBOSE_ARG --depth=1 --single-branch "https://github.com/tmux-plugins/tpm" "${config.xdg.configHome}/tmux/plugins/tpm"
      fi
    '';

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  home.stateVersion = "23.11";
}
