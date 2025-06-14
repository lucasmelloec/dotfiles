{
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
}
