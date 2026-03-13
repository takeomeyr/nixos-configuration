{ config, pkgs, ... }:

{
  # Imports:
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.11";

  # Boot:
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  # Networking:
  networking = {
    hostName = "nix-pc";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  # Time & Locale:
  time.timeZone = "Europe/Moscow";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  # Users:
  users.users.alex = {
    isNormalUser = true;
    description = "Alex";

    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
  };

  # Hardware:
  hardware = {
    pulseaudio.enable = false;
    graphics.enable = true;
  };
  security.rtkit.enable = true;

  # Virtualisation:
  virtualisation.docker.enable = true;

  # Services:
  services = {
    # System maintenance:
    fstrim.enable = true;
    fwupd.enable = true;

    # Printing and filesystem:
    printing.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    # Flatpak:
    flatpak.enable = true;

    # Logging:
    journald.extraConfig = ''
      SystemMaxUse=500M
      RuntimeMaxUse=200M
    '';

    # SSH:
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    # Audio:
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    # X11 / GNOME:
    xserver = {
      enable = true;
      xkb.layout = "us";
      videoDrivers = [ "amdgpu" ];
      libinput.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
    };
  };

  # Desktop portals:
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  # Programs:
  programs = {
    firefox.enable = true;
    thunar.enable = true;
    mtr.enable = true;
    bash.enableCompletion = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Packages:
  environment = {
    localBinInPath = true;
    systemPackages = with pkgs; [
      vim
      git
      wget
      curl
      fastfetch
      kitty
      btop
      ripgrep
      fd
      tree
      unzip
      zip
    ];
  };

  # Performance:
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # Nix:
  nix = {
    useChroot = true;
    settings = {
      experimental-features = [
        "nix-command"
        # "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "alex"
      ];
      keep-outputs = true;
      keep-derivations = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Sudo:
  security.sudo = {
    enable = true;

    extraConfig = ''
      Defaults timestamp_timeout=30
      Defaults pwfeedback
    '';
  };

  # Auto Upgrade:
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  # Nixpkgs:
  nixpkgs.config.allowUnfree = true;
}
