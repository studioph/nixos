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
      "application/json-patch+json" = "codium.desktop";
      "application/json" = "codium.desktop";
      "application/json5" = "codium.desktop";
      "application/schema+json" = "codium.desktop";
      "application/sql" = "codium.desktop";
      "application/toml" = "codium.desktop";
      "application/x-matroska" = "vlc.desktop";
      "application/x-shellscript" = "codium.desktop";
      "application/xml" = "codium.desktop";
      "application/yaml" = "codium.desktop";
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
      "inode/directory" = ["org.kde.dolphin.desktop" "codium.desktop"];
      "text/calendar" = "thunderbird.desktop";
      "text/css" = "codium.desktop";
      "text/csv-schema" = "codium.desktop";
      "text/csv" = "codium.desktop";
      "text/javascript" = "codium.desktop";
      "text/markdown" = "codium.desktop";
      "text/plain" = ["org.kde.kate.desktop" "codium.desktop"];
      "text/richtext" = "codium.desktop";
      "text/rust" = "codium.desktop";
      "text/tab-separated-values" = "codium.desktop";
      "text/x-c++hdr" = "codium.desktop";
      "text/x-c++src" = "codium.desktop";
      "text/x-chdr" = "codium.desktop";
      "text/x-cmake" = "codium.desktop";
      "text/x-csharp" = "codium.desktop";
      "text/x-csrc" = "codium.desktop";
      "text/x-gherkin" = "codium.desktop";
      "text/x-go" = "codium.desktop";
      "text/x-gradle" = "codium.desktop";
      "text/x-groovy" = "codium.desktop";
      "text/x-java" = "codium.desktop";
      "text/x-kotlin" = "codium.desktop";
      "text/x-log" = "codium.desktop";
      "text/x-makefile" = "codium.desktop";
      "text/x-matlab" = "codium.desktop";
      "text/x-maven+xml" = "codium.desktop";
      "text/x-python" = "codium.desktop";
      "text/x-python3" = "codium.desktop";
      "text/x-qml" = "codium.desktop";
      "text/x-readme" = "codium.desktop";
      "text/x-rst" = "codium.desktop";
      "text/x-sass" = "codium.desktop";
      "text/x-scala" = "codium.desktop";
      "text/x-scss" = "codium.desktop";
      "text/x-systemd-unit" = "codium.desktop";
      "video/3gp" = "vlc.desktop";
      "video/3gpp" = "vlc.desktop";
      "video/3gpp2" = "vlc.desktop";
      "video/avi" = "vlc.desktop";
      "video/divx" = "vlc.desktop";
      "video/dv" = "vlc.desktop";
      "video/fli" = "vlc.desktop";
      "video/flv" = "vlc.desktop";
      "video/mp2t" = "vlc.desktop";
      "video/mp4" = "vlc.desktop";
      "video/mp4v-es" = "vlc.desktop";
      "video/mpeg" = "vlc.desktop";
      "video/msvideo" = "vlc.desktop";
      "video/ogg" = "vlc.desktop";
      "video/quicktime" = "vlc.desktop";
      "video/vnd.divx" = "vlc.desktop";
      "video/vnd.mpegurl" = "vlc.desktop";
      "video/vnd.rn-realvideo" = "vlc.desktop";
      "video/webm" = "vlc.desktop";
      "video/x-avi" = "vlc.desktop";
      "video/x-flv" = "vlc.desktop";
      "video/x-m4v" = "vlc.desktop";
      "video/x-matroska" = "vlc.desktop";
      "video/x-mpeg2" = "vlc.desktop";
      "video/x-ms-asf" = "vlc.desktop";
      "video/x-ms-wmv" = "vlc.desktop";
      "video/x-ms-wmx" = "vlc.desktop";
      "video/x-msvideo" = "vlc.desktop";
      "video/x-ogm" = "vlc.desktop";
      "video/x-ogm+ogg" = "vlc.desktop";
      "video/x-theora" = "vlc.desktop";
      "video/x-theora+ogg" = "vlc.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/mailto" = "thunderbird.desktop";
    };
  };
}
