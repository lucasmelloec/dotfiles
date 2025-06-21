{ inputs, config, pkgs, lib, ... }: {
  home.username = "chaps";
  home.homeDirectory = "/home/chaps";

  home.packages = with pkgs; [
    fuzzel
    git
    fzf
    tmux
    gnumake
    unzip
    ripgrep
    fd
    eza
    zsh
    zoxide
    starship
    # GUI
    alacritty
    fuzzel
    wlogout
    _1password-gui
    telegram-desktop
  ];

  programs.zoxide.enable = true;
  programs.starship.enable = true;

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

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.configFile = {
    zsh = { source = ../zsh/.config/zsh; };
    tmux = {
      recursive = true;
      source = ../tmux/.config/tmux;
    };
    fuzzel = { source = ../fuzzel/.config/fuzzel; };
    git = { source = ../git/.config/git; };
    starship = { source = ../starship/.config/starship; };
    alacritty = { source = ../alacritty/.config/alacritty; };
    nvim = {
      recursive = true;
      source = ../nvim/.config/nvim;
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
