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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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
    wget
    git
    tmux
    psmisc
    pciutils
    zsh
    gcc
    waybar
    (pkgs.buildFHSEnv {
      name = "nvim";
      targetPkgs = pkgs:
        with pkgs; [
          neovim
          nodejs_22
          lua-language-server
          stylua
        ];
      runScript = "nvim";
    })
    wl-clipboard
    # Nix Language Server
    nil
    discord
  ];

  fonts.packages = builtins.filter lib.attrsets.isDerivation
    (builtins.attrValues pkgs.nerd-fonts);

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

  programs.river = { enable = true; };

  programs.firefox = let
    trueAndLocked = {
      Value = true;
      Status = "locked";
    };
    falseAndLocked = {
      Value = false;
      Status = "locked";
    };
  in {
    enable = true;
    languagePacks = [ "en-US" "pt-BR" ];
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      Homepage = {
        Locked = true;
        StartPage = "previous-session";
      };
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar =
        "newtab"; # alternatives: "always", "never" or "newtab"
      DisplayMenuBar =
        "default-off"; # alternatives: "always", "never", "default-off" or "default-on"
      SearchBar = "unified"; # alternative: "unified" or "separate"
      ExtensionSettings = {
        "*".installation_mode =
          "blocked"; # blocks all addons except the ones specified below
        # 1Password:
        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        # Privacy Badger
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        # uBlock Origin:
        "uBlock0@raymondhill.net" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # Vimium:
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          installation_mode = "force_installed";
        };
        # xBrowserSync:
        "{019b606a-6f61-4d01-af2a-cea528f606da}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/xbs/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      Preferences = {
        "browser.contentblocking.category" = {
          Value = "strict";
          Status = "locked";
        };
        "extensions.pocket.enabled" = falseAndLocked;
        "extensions.screenshots.disabled" = trueAndLocked;
        "browser.topsites.contile.enabled" = falseAndLocked;
        "browser.search.suggest.enabled" = falseAndLocked;
        "browser.search.suggest.enabled.private" = falseAndLocked;
        "browser.urlbar.suggest.searches" = falseAndLocked;
        "browser.urlbar.showSearchSuggestionsFirst" = trueAndLocked;
        "browser.newtabpage.activity-stream.feeds.section.topstories" =
          falseAndLocked;
        "browser.newtabpage.activity-stream.feeds.snippets" = falseAndLocked;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" =
          falseAndLocked;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" =
          falseAndLocked;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" =
          falseAndLocked;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" =
          falseAndLocked;
        "browser.newtabpage.activity-stream.showSponsored" = falseAndLocked;
        "browser.newtabpage.activity-stream.system.showSponsored" =
          falseAndLocked;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" =
          falseAndLocked;
        "browser.translations.automaticallyPopup" = falseAndLocked;
      };
    };
  };

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

  programs.auto-cpufreq.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "23.11";
}
