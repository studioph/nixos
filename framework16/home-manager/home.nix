{ username, ... }:
{
    imports = [
        ./pkgs.nix
        ./codium.nix
        ./plasma.nix
        ./firefox.nix
        ./terminal.nix
    ];
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

        file."gitconfig" = {
            source = ./configs/gitconfig;
            target = ".gitconfig";
        };

        file."gitignore" = {
            source = ./configs/global.gitignore;
            target = ".gitignore";
        };

        file."pdm config" = {
            source = ./configs/pdm.toml;
            target = ".config/pdm/config.toml";
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

    programs.thunderbird = {
        enable = true;
        profiles.studiop = {
            isDefault = true;
        };
    };

    programs.yt-dlp.enable = true;


    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    programs.git.enable = true;

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";
}
