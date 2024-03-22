{ config, pkgs, lib, inputs, ... }:
{
  home.username = "chaps";
  home.homeDirectory = "/home/chaps";
  
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs;[
    fuzzel
    git
    nodejs_20
    nerdfonts
    asdf-vm
    fzf
    tmux
    # This is for AGS
    dart-sass
    # GUI
    alacritty
    fuzzel
    floorp
    wlogout
    _1password-gui
  ];

  programs.zoxide.enable = true;
  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.ags = {
    enable = true;
    configDir = null;
    extraPackages = with pkgs; [
      vte
      webkitgtk_4_1
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.configFile = {
    hypr = {
      source = ../hypr/.config/hypr;
    };
    ags = {
      recursive = true;
      source = ../ags/.config/ags;
    };
    zsh = {
      source = ../zsh/.config/zsh;
    };
    tmux = {
      recursive = true;
      source = ../tmux/.config/tmux;
    };
    fuzzel = {
      source = ../fuzzel/.config/fuzzel;
    };
    git = {
      source = ../git/.config/git;
    };
    starship = {
      source = ../starship/.config/starship;
    };
    alacritty = {
      source = ../alacritty/.config/alacritty;
    };
  };

  home.activation.install-tmux-tpm = lib.hm.dag.entryAfter [ "installPackages" ]''
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
