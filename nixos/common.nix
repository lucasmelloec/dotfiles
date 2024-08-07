{ config, lib, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chaps = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "kvm" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    tmux
    psmisc
    pciutils
    zsh
    gcc
  ];

  programs.zsh.enable = true;
  # For zsh autocompletion to work
  environment.pathsToLink = [ "/share/zsh" ];
  
  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };
  environment.variables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  # This is a hack for mason (that makes the whole system weird)
  programs.nix-ld.enable = true;

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = 5;

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Enable Pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "23.11";
}
