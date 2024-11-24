{ pkgs, username, extensions, unstable, ... }:

let
    dotnetSDK = pkgs.dotnet-sdk_8;
    compatibleExtensions = extensions.forVSCodeVersion(pkgs.vscodium.version);

in
{
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home = {
        username = "${username}";
        homeDirectory = "/home/${username}";

        # This value determines the Home Manager release that your
        # configuration is compatible with. This helps avoid breakage
        # when a new Home Manager release introduces backwards
        # incompatible changes.
        #
        # You can update Home Manager without changing this value. See
        # the Home Manager release notes for a list of state version
        # changes in each release.
        stateVersion = "23.11";

        file."starship config" = {
            source = ./configs/starship.toml;
            target = ".config/starship.toml";
        };

        file."VSCodium settings" = {
            source = ./configs/vscodium-settings.json;
            target = ".config/VSCodium/User/settings.json";
        };

        file."konsole profile" = {
            source = ./configs/studiop.profile;
            target = ".local/share/konsole/studiop.profile";
        };

        file."gitconfig" = {
            source = ./configs/gitconfig;
            target = ".gitconfig";
        };

        file."firefox overrides" = {
            source = ./configs/firefox-overrides.js;
            target = ".mozilla/firefox/studiop/user-overrides.js";
        };

        file."gitignore" = {
            source = ./configs/global.gitignore;
            target = ".gitignore";
        };

        file."pdm config" = {
            source = ./configs/pdm.toml;
            target = ".config/pdm/config.toml";
        };

        packages = (with pkgs; [
            kdePackages.kate
            python3
            rustup
            poetry
            pdm
            virt-manager
            bitwarden
            gomplate
            marktext
            kdePackages.krdc
            ungoogled-chromium
            talosctl
            libreoffice-qt
            ffmpeg
            xdg-desktop-portal
            kdePackages.xdg-desktop-portal-kde
            kdePackages.kdeconnect-kde
            nodejs_20
            kdePackages.plasma-workspace-wallpapers
            kdePackages.plasma-browser-integration
            nerdfonts
            nextcloud-client
            kdePackages.kolourpaint
            vlc
            kdePackages.filelight
            kdePackages.skanpage
            protonmail-bridge-gui
            kdePackages.kweather
            vimix-cursors
            papirus-icon-theme
            tela-icon-theme
            fluent-icon-theme
            dotnetSDK # Defined as let var
            xournalpp
            kdePackages.kcalc
            protonmail-bridge
            qownnotes
            libsForQt5.kamoso
            nil
            dino
            kdePackages.merkuro
            kdePackages.akonadi
            kdePackages.kdepim-runtime
            kdePackages.k3b
            kdePackages.ksshaskpass
            kid3
            go-task
            gtkterm
            drawio
            android-tools
            opentofu
            kdePackages.kdenlive
            p7zip # TODO: Remove once Ark works without it
            go-task
            podman-tui
            dive
            podman-compose
            kdePackages.isoimagewriter
            kubernetes-helm
            helmfile
            kubernetes-helmPlugins.helm-diff
            kubernetes-helmPlugins.helm-git
            kubectl
            pyenv
            webcord
            netcoredbg
            hunspell
            hunspellDicts.en_US
            jetbrains.rider
        ])
        ++ (with unstable; [
            dbgate
        ]);

        sessionVariables = {
            DOTNET_ROOT = "${dotnetSDK}";
        };
    };

    dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
            autoconnect = ["qemu:///system"];
            uris = ["qemu:///system"];
        };
    };

    programs.awscli = {
        enable = true;
        settings = {
            "default" = {
                region = "us-east-1";
                output = "json";
            };
            "archive" = {
                region = "eu-north-1";
                output = "json";
            };
        };
    };

    programs.go.enable = true;

    programs.htop.enable = true;

    programs.java.enable = true;

    programs.k9s.enable = true;

    programs.pyenv.enable = true;

    programs.ssh = {
        enable = true;
        matchBlocks = {
            "coreos" = {
                hostname = "coreos.studiop";
                user = "core";
                identityFile = "~/.ssh/coreos";
                extraOptions = { StrictHostKeyChecking = "no"; };
            };
            "truenas" = {
                hostname = "truenas.studiop";
                user = "admin";
                identityFile = "~/.ssh/truenas";
            };
        };
    };

    programs.starship.enable = true;

    programs.thunderbird = {
        enable = true;
        profiles.studiop = {
            isDefault = true;
        };
    };

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        # Disabled otherwise it causes file conflict since home-manager tries to generate a separate settings.json
        # These are set in the symlinked settings.json from the configs folder
#         enableUpdateCheck = false;
#         enableExtensionUpdateCheck = false;
        mutableExtensionsDir = true; # Required for stupid .NET extensions
        extensions = (with compatibleExtensions.open-vsx; [
            adguard.adblock
            antfu.icons-carbon
            csharpier.csharpier-vscode
            detachhead.basedpyright
            devsense.phptools-vscode
            ecmel.vscode-html-css
            equinusocio.vsc-material-theme
            fernandoescolar.vscode-solution-explorer
            golang.go
            hangxingliu.vscode-systemd-support
            hashicorp.terraform
            jnoortheen.nix-ide
            mechatroner.rainbow-csv
            mkhl.direnv
            ms-azuretools.vscode-docker
            ms-kubernetes-tools.vscode-kubernetes-tools
            ms-python.black-formatter
            ms-python.isort
            ms-python.pylint
            ms-python.python
            ms-vscode.hexeditor
            pkief.material-icon-theme
            redhat.java
            redhat.vscode-xml
            redhat.vscode-yaml
            ritwickdey.liveserver
            tamasfe.even-better-toml
            timonwong.shellcheck
            tomoyukim.vscode-mermaid-editor
            tyriar.sort-lines
            yzhang.markdown-all-in-one
#             muhammad-sammy.csharp # Have to install manually cause it also dynamically downloads Omnisharp into it's folder
        ])
        ++ (with compatibleExtensions.open-vsx-release; [
            eamodio.gitlens
            rust-lang.rust-analyzer
        ])
        ++ (with compatibleExtensions.vscode-marketplace; [
            ms-dotnettools.vscode-dotnet-runtime
        ]);
    };

    programs.yt-dlp.enable = true;

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

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    programs.git.enable = true;

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    programs.bash = {
        enable = true;
        shellAliases = {
            docker = "podman";
            terraform = "tofu";
        };
    };

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
        };
    };

    services.flatpak.packages = [
        "com.usebottles.bottles"
    ];
}
