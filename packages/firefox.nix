{ config, pkgs, ... }:

let
  lock-true = {
    Value = true;
    Status = "locked";
  };
  lock-false = {
    Value = false;
    Status = "locked";
  };
  blank-str = {
    Value = "";
    Status = "locked";
  };
  unstable = import <nixos-unstable> { };
in
{
  programs = {
    firefox = {
      enable = true;
      package = unstable.librewolf;
      languagePacks = [ "en-US" ];
      policies = {
        # Prevent non-declarative changes to Firefox
        # BlockAboutConfig = true;
        DisableTelemetry = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        # bleh
        DisableFormHistory = true;
        DisablePasswordReveal = true;
        EnableTrackingProtection = {
          #Value = true;
          # Prevent accidental disable + declarative-only
          #Locked = true;
          # Cryptomining = true;
          #Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "never";
        DisplayMenuBar = "default-off";
        SearchBar = "unified";
        FirefoxHome = {
          Search = false;
          TopSites = false;
          # :vomit:
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          # :vomit:^2
          SponsoredPocket = false;
          Snippets = false;
          # Prevent accidental disable + declarative-only
          Locked = true;
        };
        FirefoxSuggest = {
          WebSuggestions = false;
          SponsoredSuggestions = false;
          ImproveSuggest = false;
          # Prevent accidental disable + declarative-only
          Locked = true;
        };
        NetworkPrediction = false;
        # Use keepassxc
        OfferToSaveLogins = false;
        # Use keepassxc
        PasswordManagerEnabled = false;
        PDFjs = {
          # Don't fuck with copy-paste.
          EnablePermissions = false;
        };
        Permissions = {
          Location = {
            BlockNewRequests = true;
            Locked = true;
          };
          # worst browser feature of the 21st century
          Notifications = {
            BlocknewRequests = true;
            Locked = true;
          };
        };

        ExtensionSettings = {
          "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
          # UBlock Origin (latest)
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          # Sponsorblock (latest)
          #"sponsorBlocker@ajay.app" = {
          #  install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          #  installation_mode = "force_installed";
          #};
          # CookieAutoDelete (pinned)
          "CookieAutoDelete@kennydo.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4040738/cookie_autodelete-3.8.2.xpi";
            installation_mode = "force_installed";
          };
          # Decentraleyes (pinned)
          "jid1-BoFifL9Vbdl2zQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4255788/decentraleyes-2.0.19.xpi";
            installation_mode = "force_installed";
          };
          ## ClearURLs (pinned)
          #"{74145f27-f039-47ce-a470-a662b129930a}" = {
          #  install_url = "https://addons.mozilla.org/firefox/downloads/file/4064884/clearurls-1.26.1.xpi";
          #  installation_mode = "force_installed";
          #};
          # Port Authority (Block LAN attacks)
          "{6c00218c-707a-4977-84cf-36df1cef310f}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4481055/port_authority-2.1.0.xpi";
            installation_mode = "force_installed";
          };
          "{c607c8df-14a7-4f28-894f-29e8722976af}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/3723251/temporary_containers-1.9.2.xpi";
            installation_mode = "force_installed";
          };
        };

        Preferences = {
          # Preferences you'd think you'd be able to set via
          # GPO but alas, cannot, for vague "stability" reasons
          # The common theme with all of these is they are explicitly used for privacy hardening configuration.
          "app.normandy.enabled" = lock-false;
          "app.normandy.api_url" = blank-str;
          "app.shield.optoutstudies.enabled" = lock-false;
          "beacon.enabled" = lock-false;
          "breakpad.reportURL" = blank-str;
          "captivedetect.canonicalURL" = blank-str;
          "datareporting.healthreport.uploadEnabled" = lock-false;
          "javascript.use_us_english_locale" = lock-true;
          # Mozilla domains get special perms
          "permissions.manager.defaultsUrl" = blank-str;
          "privacy.clearOnShutdown.cache" = lock-true;
          "privacy.clearOnShutdown.cookies" = lock-true;
          "privacy.clearOnShutdown.downloads" = lock-true;
          "privacy.clearOnShutdown.formdata" = lock-true;
          # Controversial, but I like my history
          "privacy.clearOnShutdown.history" = lock-false;
          "privacy.clearOnShutdown.offlineApps" = lock-true;
          "privacy.clearOnShutdown.sessions" = lock-false;
          # site permissions
          "privacy.clearOnShutdown.sitesettings" = lock-true;
          # Actually makes fingerprinting easier
          "privacy.donottrackheader.enabled" = lock-false;
          "privacy.firstparty.isolate" = lock-true;
          "privacy.partition.always_partition_third_party_non_cookie_storage" = lock-true;
          "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = lock-true;
          "privacy.partition.serviceWorkers" = lock-true;
          "privacy.resistFingerprinting" = lock-true;
          "privacy.resistFingerprinting.block_mozAddonManager" = lock-true;
          "privacy.sanitize.sanitizeOnShutdown" = lock-true;
          "privacy.sanitize.timeSpan" = { Value = 0; Status = "locked"; };
          "privacy.trackingprotection.enabled" = lock-true;
          # Containers
          "privacy.userContext.enabled" = lock-true;
          "privacy.userContext.ui.enabled" = lock-true;
          "privacy.window.maxInnerWidth" = { Value = 1600; Status = "locked"; };
          "privacy.window.maxInnerHeight" = { Value = 900; Status = "locked"; };
          # Don't allow PKP MiTM by user (e.g. AV)
          "security.cert_pinning.enforcement_level" = { Value = 2; Status = "locked"; };
          "security.pki.crlite_mode" = { Value = 2; Status = "locked"; };
          # Don't allow SHA-1 certs
          "security.pki.sha1_enforcement_level" = { Value = "1"; Status = "locked";};
          # CRLite (use it for Revoked and Not Revoked)
          "security.remote_settings.crlite_filters.enabled" = lock-true;
          "toolkit.coverage.endpoint.base" = blank-str;
          "toolkit.coverage.opt-out" = lock-true;
          "toolkit.telemetry.archive.enabled" = lock-false;
          "toolkit.telemetry.bhrPing.enabled" = lock-false;
          "toolkit.telemetry.coverage.opt-out" = lock-true;
          "toolkit.telemetry.enabled" = lock-false;
          "toolkit.telemetry.firstShutdownPing.enabled" = lock-false;
          "toolkit.telemetry.newProfilePing.enabled" = lock-false;
          "toolkit.telemetry.server" = { Value = "data:,"; Status = "locked"; };
          "toolkit.telemetry.shutdownPingSender.enabled" = lock-false;
          "toolkit.telemetry.unified" = lock-false;
          "toolkit.telemetry.updatePing.enabled" = lock-false;
          # May reenable but
          # webgl.disabled" = lock-true;


          #  Disables WebRTC
          "media.peerconnection.enabled" = lock-false;

          # DNS shenanigans
          #  (3 if uri is set)
          # "network.trr.mode" = { Value = 5; Status = "locked"; };
          # "network.trr.uri" = "";

          # From https://brainfucksec.github.io/firefox-hardening-guide#aboutconfig
          "browser.aboutConfig.showWarning" = lock-false;
          # home
          "browser.startup.page" = { Value = 1; Status = "locked"; };
          "browser.startup.homepage" = { Value = "about:home"; Status = "locked"; };
          "browser.newtabpage.enabled" = lock-false;
          "browser.newtab.preload" = lock-false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = lock-false;
          "browser.newtabpage.activity-stream.telemetry" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
          "browser.newtabpage.activity-stream.default.sites" = lock-false;

          # Location
          # No geolocation (no point either, what kind of laptop carries a GPS module nowadays?)
          "geo.enabled" = lock-false;
          "geo.provider.use_geoclue" = lock-false;
          "geo.provider.use_gpsd" = lock-false;
          "browser.region.network.url" = blank-str;
          "browser.region.update.enabled" = lock-false;

          # Language/locale
          "intl.accept_languages" = "en-US, en";

          # Updates (NixOS does this for me.)
          "app.update.background.scheduling.enabled" = lock-false;
          "app.update.auto" = lock-false;
          "extensions.getAddons.showPane" = lock-false;
          "extensions.htmlaboutaddons.recommendations.enabled" = lock-false;
          "browser.discovery.enabled" = lock-false;

          # Telemetry
          "datareporting.policy.dataSubmissionEnabled" = lock-false;
          "browser.ping-centre.telemetry" = lock-false;

          # Crash reports
          "browser.tabs.crashReporting.sendReport" = lock-false;

          # Captive Portal Detection / Network Checks
          "network.captive-portal-service.enabled" = lock-false;
          "network.connectivity-service.enabled" = lock-false;

          # Safe browsing (my DNS server does this for me)
          "browser.safebrowsing.malware.enabled" = lock-false;
          "browser.safebrowsing.phishing.enabled" = lock-false;
          "browser.safebrowsing.downloads.enabled" = lock-false;
          "browser.safebrowsing.provider.google4.gethashURL" = blank-str;
          "browser.safebrowsing.provider.google4.updateURL" = blank-str;
          "browser.safebrowsing.provider.google.gethashURL" = blank-str;
          "browser.safebrowsing.provider.google.updateURL" = blank-str;
          "browser.safebrowsing.provider.google4.dataSharingURL" = blank-str;
          "browser.safebrowsing.downloads.remote.enabled" = lock-false;
          "browser.safebrowsing.downloads.remote.url" = blank-str;
          "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = lock-false;
          "browser.safebrowsing.downloads.remote.block_uncommon" = lock-false;
          # disables accidental override
          "browser.safebrowsing.allowOverride" = lock-false;

          # prefetching
          ## links
          "network.prefetch-next" = lock-false;
          ## DNS
          "network.dns.disablePrefetch" = lock-true;
          ## Predictor
          "network.predictor.enabled" = lock-false;
          ## mouseover makes connection
          "network.http.speculative-parallel-limit" = { Value = 0; Status = "locked"; };
          "browser.places.speculativeConnect.enabled" = lock-false;
          "network.dns.disableIPv6" = lock-true;
          # GIO protos can bypass proxy
          "network.gio.supported-protocols" = blank-str;
          # UNC can bypass proxy
          "network.file.disable_unc_paths" = lock-true;
          # Mitigate unicode homograph attacks
          "network.IDN_show_punycode" = lock-true;

          # Suggestions & autofill
          "browser.search.suggest.enabled" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;
          "browser.fixup.alternate.enabled" = lock-false;
          # Display everything in the URL (minimalism has gone too far)
          "browser.urlbar.trimURLs" = lock-false;
          "browser.urlbar.speculativeConnect.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "extensions.formautofill.addresses.enabled" = lock-false;
          "extensions.formautofill.available" = { Value = "off"; Status = "locked"; };
          "extensions.formautofill.creditCards.available" = lock-false;
          "extensions.formautofill.creditCards.enabled" = lock-false;
          "extensions.formautofill.heuristics.enabled" = lock-false;
          "browser.urlbar.quicksuggest.scenario" = { Value = "history"; Status = "locked"; };
          "browser.urlbar.quicksuggest.enabled" = lock-false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = lock-false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = lock-false;

          # Passwords (KeepassXC exists)
          "signon.rememberSignons" = lock-false;
          "signon.autofillForms" = lock-false;
          "signon.formlessCapture.enabled" = lock-false;
          # 1 means XOrigin sub-resources can't open HTTP basic auth dialogs
          # "network.auth.subresource-http-auth-allow" = { Value = 1; Status = "locked"; };

          # Disk Cache/memory
          "browser.cache.disk.enable" = lock-false;
          # Disable storing extra session data. Things like forms, scroll positions, cookies, POST data.
          # 2 = nowhere
          "browser.sessionstore.privacy_level" = { Value = 2; Status = "locked"; };
          "browser.sessionstore.resume_from_crash" = lock-false;
          "browser.pagethumbnails.capturing_disabled" = lock-true;
          "browser.shell.shortcutFavicons" = lock-false;
          "browser.helperApps.deleteTempFileOnExit" = lock-true;

          # HTTPS/general crypto
          "dom.security.https_only_mode" = lock-true;
          "dom.security.https_only_mode_send_http_background_request" = lock-false;
          # Show actually useful info for Insecure connection pages
          "browser.xul.error_pages.expert_bad_cert" = lock-true;
          "security.tls.enable_0rtt_data" = lock-false;
          "security.OCSP.require" = lock-true;

          # Audio/Video
          # WebRTC inside proxy
          "media.peerconnection.ice.proxy_only_if_behind_proxy" = lock-true;
          # Single net interface for ICE candidates
          "media.peerconnection.ice.default_address_only" = lock-true;
          # Exclude private IPs
          "media.peerconnection.ice.no_host" = lock-true;
          # Autoplay, block all
          "media.autoplay.default" = { Value = 5; Status = "locked"; };

          # Downloads
          # Always ask where to save
          "browser.download.useDownloadDir" = lock-false;
          # Don't add downloads to recent documents
          "browser.download.manager.addToRecentDocs" = lock-false;

          # Cookies
          # "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };

          # UI features
          "pdfjs.enableScripting" = lock-false;
          "dom.disable_open_during_load" = lock-true;
          "dom.popup_allowed_events" = { Value = "click dblclick mousedown pointerdown"; Status = "locked"; };

          # Extensions
          # Extensions work on restricted domains, scope is profile+applications
          "extensions.enabledScopes" = { Value = "5"; Status = "locked"; };
          "extensions.webextensions.restrictedDomains" = blank-str;
          # Always display install prompt
          "extensions.postDownloadThirdPartyPrompt" = lock-false;

          # Shutdown settings
          "browser.display.use_system_colors" = lock-false;

          # Disable DRM (disabled for now)
          "media.eme.enabled" = lock-false;

          # Headers / Referers
          # Only send referrer to same base domains (host-only might break things)
          # "network.http.referer.XOriginPolicy" = { Value = 1; Status = "locked"; };
          # scheme+host+port
          # "network.http.referer.XOriginTrimmingPolicy" = { Value = 2; Status = "locked"; };
        }; # /preferences
      }; # /policies
    };
  };
}
