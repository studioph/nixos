{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    #nativeMessagingHosts.packages = [ pkgs.plasma-browser-integration ];
    profiles.studiop = {
      isDefault = true;
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
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
        kagi-search
      ];
      search = {
        default = "kagi";
        privateDefault = "kagi";
        force = true;
        order = [ "kagi" "ddg" ];

        engines = {
          kagi = {
            name = "Kagi";
            urls = [
                 {
                   template = "https://kagi.com/search?";
                   params = [
                     {
                       name = "q";
                       value = "{searchTerms}";
                     }
                   ];
                 }
               ];
            icon = "https://kagi.com/asset/45772d7/kagi_assets/logos/dark_2.svg";
            definedAliases = ["@kagi"];
          };

          bing.metaData.hidden = true;
          google.metaData.hidden = true;
          "amazon.com".metaData.hidden = true;
          amazondotcom-us.metaData.hidden = true;
          ebay.metaData.hidden = true;
        };
      };
    };
    };
  };

  home.file."firefox overrides" = {
    source = ./configs/firefox-overrides.js;
    target = ".mozilla/firefox/studiop/user-overrides.js";
  };
}
