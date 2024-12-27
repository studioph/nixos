{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    #nativeMessagingHosts.packages = [ pkgs.plasma-browser-integration ];
    profiles.studiop = {
      isDefault = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        canvasblocker
        clearurls
        facebook-container
        floccus
        multi-account-containers
        old-reddit-redirect
        plasma-integration
        skip-redirect
        tabliss
      ];
      search = {
        default = "DuckDuckGo";
        force = true;
      };
    };
  };

  home.file."firefox overrides" = {
    source = ./configs/firefox-overrides.js;
    target = ".mozilla/firefox/studiop/user-overrides.js";
  };
}
