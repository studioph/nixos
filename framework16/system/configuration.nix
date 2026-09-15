# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, username, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./persist.nix
    ];

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelParams = [
      "amdgpu.abmlevel=0"
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
      # Avoid waiting for password prompt
      "plymouth.use-simpledrm"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "sg" ];
    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    initrd.systemd.enable = true;

    # plymouth, showing after LUKS unlock
    plymouth = {
      enable = true;
      theme = "spin";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "circle" "circle_flow" "loader" "polaroid" "spin"];
        })
        plymouth-vortex-ubuntu-theme
        kdePackages.breeze-plymouth
      ];
    };
  };
  networking.hostName = "studiop"; # Define your hostname.
  networking.hostId = "007f0200";
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  services.resolved.enable = true;
  services.resolved.settings.Resolve.FallbackDns = [ ];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-frappe";
  };
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    # Configure keymap in X11
    xkb = {
      variant = "";
      layout = "us";
    };
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin pkgs.gutenprint pkgs.gutenprintBin ];
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    description = "Paul Hutchings";
    group = "paul";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "dialout" "scanner" "lp" "cdrom" "adbusers" ];
    autoSubUidGidRange = true;
  };
  users.users.root = {
    hashedPassword = "!";
    autoSubUidGidRange = true;
  };
  users.mutableUsers = true;
  users.groups."paul".gid = 1000;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wireguard-tools
    curl
    dnsutils
    rsync
    yq-go
    zip
    unzip
    pigz
    p7zip
    usbutils
    pciutils
    nmap
    kdePackages.plasma-thunderbolt
    thunderbolt
    cifs-utils
    nfs-utils
    virtiofsd
    openssl
    amdgpu_top
    usbutils
    kdePackages.sddm-kcm
    (
      pkgs.catppuccin-sddm.override {
        flavor = "frappe";
        font = "Noto Sans";
        fontSize = "12";
        background = "${./catppuccin.jpg}";
        loginBackground = true;
        #         clockEnabled = true;
      }
    )
    smartmontools
    kdePackages.print-manager
    kdePackages.ksystemlog
    kdePackages.kompare
    kdiff3
    lsof
    distrobox
  ];
  services.hardware.bolt.enable = true;
  #programs.kdeconnect.enable = true;
  #programs.npm.enable = true;
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.onShutdown = "shutdown";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPortRanges = [
      { from = 8000; to = 9000; }
    ];

    # if packets are still dropped, they will show up in dmesg
    logReversePathDrops = true;
    # wireguard trips rpfilter up
    extraCommands = ''
      ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 58120 -j RETURN
      ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 58120 -j RETURN
    '';
    extraStopCommands = ''
      ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 58120 -j RETURN || true
      ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 58120 -j RETURN || true
    '';
  };
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  #   security.polkit.adminIdentities = [ ];
  #   boot.initrd.postDeviceCommands = lib.mkAfter ''
  #     zfs rollback -r rpool/local/root@blank
  #   '';

  zramSwap.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nix = {
    package = pkgs.nixVersions.stable;
    #     nixPath = [
    #       "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    #       "nixos-config=${config.users.users.${username}.home}/.config/nixos/config.nix"
    #       "/nix/var/nix/profiles/per-user/root/channels"
    #     ];
    settings = {
      allowed-users = [ "@wheel" ];
      experimental-features = [ "nix-command flakes" ];
      auto-optimise-store = true;
      download-buffer-size = 524288000;
    };
  };

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=25%" "mode=755" ];
  };

  fileSystems."/mnt/ssd" = {
    device = "/dev/disk/by-uuid/07e7c70c-0113-4028-80b9-32b4d7a3dcf4";
    fsType = "ext4";
    neededForBoot = true;
  };

  fileSystems."/persist" = {
    neededForBoot = true;
    depends = [
      "/mnt/ssd"
    ];
    device = "/mnt/ssd/persist";
    fsType = "none";
    options = [ "bind" "noatime" ];
  };

  fileSystems."/nix" = {
    depends = [
      "/mnt/ssd"
    ];
    device = "/mnt/ssd/nix";
    fsType = "none";
    options = [ "bind" "noatime" ];
  };

  programs.dconf.enable = true;

  programs.partition-manager.enable = true;

  networking.firewall.enable = true;
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;
  services.fprintd.enable = true;
  systemd.network.wait-online.enable = false;
  services.flatpak.enable = true;

  environment.sessionVariables = {
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.epkowa ];
  };

  hardware.opentabletdriver.enable = true;

  security.pki.certificateFiles = [ ./universal-root.crt.pem ];

  programs.nix-ld.enable = true;
  programs.ssh.startAgent = true;

  systemd.mounts =
    let
      commonMountOptions = {
        type = "cifs";
        mountConfig = {
          Options = "rw,noatime,uid=1000,gid=1000,cache=none,vers=3.0";
        };
      };
    in
    [
      (commonMountOptions // {
        what = "//qnap.studiop/downloads";
        where = "/mnt/qnap";
      })
      (commonMountOptions // {
        what = "//truenas.studiop/media";
        where = "/mnt/truenas/media";
      })
    ];
}
