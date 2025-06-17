{ pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    wget
    git
    psmisc
    pciutils
    unzip
    fzf
    ripgrep
    fd
    eza
    comma
    nh
    sbctl
  ];

  programs.nix-index-database.comma.enable = true;

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = 2;

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Modules
  imports =
    [ ./modules ./users inputs.nix-index-database.nixosModules.nix-index ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "23.11";
}
