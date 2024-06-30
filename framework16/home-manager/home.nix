{ pkgs, username, extensions, ... }:

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

        file."giignore" = {
            source = ./configs/global.gitignore;
            target = ".gitignore";
        };

        packages = with pkgs; [
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
            terraform
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
            dotnet-sdk_7
            xournalpp
            kdePackages.kcalc
            protonmail-bridge
            qownnotes
            libsForQt5.kamoso
            nil
            kaidan
            dino
            kdePackages.merkuro
            kdePackages.akonadi
            kdePackages.kdepim-runtime
            gtkterm
        ];

        sessionVariables = {
            DOTNET_CLI_TELEMETRY_OPTOUT = "1";
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

    programs.vscode = {
        enable = true;
        package = pkgs.vscodium.fhs;
        # Disabled otherwise it causes file conflict since home-manager tries to generate a separate settings.json
        # These are set in the symlinked settings.json from the configs folder
#         enableUpdateCheck = false;
#         enableExtensionUpdateCheck = false;
        mutableExtensionsDir = true; # Required for stupid .NET extensions
        extensions = with extensions.open-vsx; [
            antfu.icons-carbon
            equinusocio.vsc-material-theme
            rust-lang.rust-analyzer
            redhat.java
            muhammad-sammy.csharp
            pkief.material-icon-theme
            redhat.vscode-xml
            timonwong.shellcheck
            hashicorp.terraform
            ms-python.python
            redhat.vscode-yaml
            rust-lang.rust-analyzer
            golang.go
            ms-kubernetes-tools.vscode-kubernetes-tools
            hangxingliu.vscode-systemd-support
            eamodio.gitlens
            ecmel.vscode-html-css
            mechatroner.rainbow-csv
            ms-vscode.hexeditor
            tamasfe.even-better-toml
            yzhang.markdown-all-in-one
            tyriar.sort-lines
            adguard.adblock
            ms-azuretools.vscode-docker
            tomoyukim.vscode-mermaid-editor
            jnoortheen.nix-ide
            ms-python.black-formatter
            ms-python.pylint
            ms-python.isort
            detachhead.basedpyright
#             extensions.vscode-marketplace.ms-python.vscode-pylance
            extensions.vscode-marketplace.ms-dotnettools.vscode-dotnet-runtime
#             extensions.vscode-marketplace.llllvvuu.llllvvuu-glspc
        ];
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
        };
    };

    services.flatpak.packages = [
        "com.usebottles.bottles"
    ];
}
