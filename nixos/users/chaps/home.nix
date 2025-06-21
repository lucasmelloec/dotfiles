{ config, pkgs, lib, ... }:

let homeDirectory = "/home/chaps";
in {
  imports = [ ../../modules/user ];
  home.username = "chaps";
  home.homeDirectory = homeDirectory;

  home.packages = with pkgs; [
    # GUI
    alacritty
    _1password-gui
    telegram-desktop
    discord
  ];

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
      source = config.lib.file.mkOutOfStoreSymlink
        "${homeDirectory}/dotfiles/tmux/.config/tmux";
    };
    fuzzel = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${homeDirectory}/dotfiles/fuzzel/.config/fuzzel";
    };
    git = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${homeDirectory}/dotfiles/git/.config/git";
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
  };

  home.activation.install-tmux-tpm =
    lib.hm.dag.entryAfter [ "installPackages" ] ''
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
