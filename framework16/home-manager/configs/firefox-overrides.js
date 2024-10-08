/* [USER OVERRIDES] ***/ 

/* 0801: disable location bar using search
 * Don't leak URL typos to a search engine, give an error message instead
 * Examples: "secretplace,com", "secretplace/com", "secretplace com", "secret place.com"
 * [NOTE] This does not affect explicit user action such as using search buttons in the
 * dropdown, or using keyword search shortcuts you configure in options (e.g. "d" for DuckDuckGo)
 * [SETUP-CHROME] Override this if you trust and use a privacy respecting search engine ***/
user_pref("keyword.enabled", true);

/* 0702: set the proxy server to do any DNS lookups when using SOCKS
 * e.g. in Tor, this stops your local DNS server from knowing your Tor destination
 * as a remote Tor node will handle the DNS request
 * [1] https://trac.torproject.org/projects/tor/wiki/doc/TorifyHOWTO/WebBrowsers ***/
user_pref("network.proxy.socks_remote_dns", false);

/* 2811: set/enforce what items to clear on shutdown (if 2810 is true) [SETUP-CHROME]
 * These items do not use exceptions, it is all or nothing (1681701)
 * [NOTE] If "history" is true, downloads will also be cleared
 * [NOTE] "sessions": Active Logins: refers to HTTP Basic Authentication [1], not logins via cookies
 * [NOTE] "offlineApps": Offline Website Data: localStorage, service worker cache, QuotaManager (IndexedDB, asm-cache)
 * [SETTING] Privacy & Security>History>Custom Settings>Clear history when Firefox closes>Settings
 * [1] https://en.wikipedia.org/wiki/Basic_access_authentication ***/
user_pref("privacy.clearOnShutdown.offlineApps", true); // [DEFAULT: false]
user_pref("privacy.clearOnShutdown.cookies", true);

// Generated by Home Manager.

user_pref("app.shield.optoutstudies.enabled", true);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.startup.homepage", "moz-extension://028e2385-e409-46de-9e24-842e594bfff4/index.html");
user_pref("datareporting.healthreport.uploadEnabled", true);
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_ever_enabled", true);
user_pref("dom.webnotifications.enabled", false);
user_pref("media.autoplay.default", 5);
user_pref("network.dns.disablePrefetch", true);
user_pref("permissions.default.camera", 2);
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);
user_pref("permissions.default.microphone", 2);
user_pref("permissions.default.xr", 2);
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.resistFingerprinting", true);
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
user_pref("signon.rememberSignons", false);
user_pref("dom.private-attribution.submission.enabled", false);
