# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, username, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "amdgpu.abmlevel=0" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = ["sg"];
  networking.hostName = "studiop"; # Define your hostname.
  networking.hostId = "007f0200";
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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
  hardware.pulseaudio.enable = false;
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
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "dialout" "scanner" "lp" "cdrom" "adbusers"];
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
    _7zz
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
        font  = "Noto Sans";
        fontSize = "12";
        background = "${./catppuccin.jpg}";
        loginBackground = true;
#         clockEnabled = true;
      }
    )
    smartmontools
    kdePackages.print-manager
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
  networking.firewall.allowedTCPPortRanges = [
    { from = 8000; to = 9000; }
  ];
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

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  nix = {
    package = pkgs.nixVersions.stable;
#     nixPath = [
#       "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
#       "nixos-config=${config.users.users.${username}.home}/.config/nixos/config.nix"
#       "/nix/var/nix/profiles/per-user/root/channels"
#     ];
    settings = {
      allowed-users = ["@wheel"];
      experimental-features = ["nix-command flakes"];
      auto-optimise-store = true;
    };
  };

#   fileSystems."/" = {
#     device = "tmpfs";
#     fsType = "tmpfs";
#     # You must set mode=755. The default is 777, and OpenSSH will complain and disallow logins
#     options = [ "relatime" "mode=755" ];
#   };
#

  programs.dconf.enable = true;

  programs.partition-manager.enable = true;

  networking.firewall.enable = true;
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;
  services.fprintd.enable = true;
  systemd.network.wait-online.enable = false;
  services.flatpak.enable = true;
  services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
  };

  environment.sessionVariables = {
      DOTNET_CLI_TELEMETRY_OPTOUT = "1";
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.epkowa ];
  };

  security.pki.certificateFiles = [./universal-root.crt.pem];

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  programs.nix-ld.enable = true;
  programs.ssh.startAgent = true;
}
