{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  networking = {
    hostName = "alex";
    networkmanager.enable = true;

    firewall = {
      enable = false;
      allowedTCPPorts = [ ];
    };
  };

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

  services.xserver = {
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

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;
  };

  users.users.alex = {
    isNormalUser = true;
    description = "Alex";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
  };

  virtualisation.docker.enable = true;

  services = {
    flatpak.enable = true;
    openssh.enable = true;
    fstrim.enable = true;
    printing.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
  };

  environment.localBinInPath = true;

  programs = {
    firefox.enable = true;
    thunar.enable = true;
    mtr.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    fastfetch
  ];

  nix = {
    useChroot = true;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" "alex" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
