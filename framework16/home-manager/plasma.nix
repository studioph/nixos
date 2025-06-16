{ ... }:
{
  programs.plasma = {
    enable = true;
    workspace = {
      clickItemTo = "select";
      lookAndFeel = "breeze";
    };

    windows = {
      allowWindowsToRememberPositions = false;
    };

    panels = [
      {
        location = "bottom";
        height = 45;
        hiding = "none";
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General.systemFavorites = "logout\\,suspend\\,reboot\\,shutdown";
            };
          }
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General.launchers = "applications:firefox.desktop,applications:chromium-browser.desktop,applications:org.kde.dolphin.desktop,applications:org.kde.konsole.desktop,applications:codium.desktop,applications:virt-manager.desktop,applications:marktext.desktop,applications:thunderbird.desktop,applications:bitwarden.desktop,applications:systemsettings.desktop";
            };
          }
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "org.kde.dolphin.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "text/plain" = "org.kde.kate.desktop";
      "audio/aac" = "vlc.desktop";
      "audio/mp4" = "vlc.desktop";
      "audio/mpeg" = "vlc.desktop";
      "audio/mpegurl" = "vlc.desktop";
      "audio/ogg" = "vlc.desktop";
      "audio/vnd.rn-realaudio" = "vlc.desktop";
      "audio/vorbis" = "vlc.desktop";
      "audio/x-flac" = "vlc.desktop";
      "audio/x-mp3" = "vlc.desktop";
      "audio/x-mpegurl" = "vlc.desktop";
      "audio/x-ms-wma" = "vlc.desktop";
      "audio/x-musepack" = "vlc.desktop";
      "audio/x-oggflac" = "vlc.desktop";
      "audio/x-pn-realaudio" = "vlc.desktop";
      "audio/x-scpls" = "vlc.desktop";
      "audio/x-speex" = "vlc.desktop";
      "audio/x-vorbis" = "vlc.desktop";
      "audio/x-vorbis+ogg" = "vlc.desktop";
      "audio/x-wav" = "vlc.desktop";
      "x-scheme-handler/mailto" = "thunderbird.desktop";
      "text/calendar" = "thunderbird.desktop";
    };
  };
}
