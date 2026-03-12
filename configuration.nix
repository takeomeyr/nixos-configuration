# /etc/nixos/configuration.nix

  { inputs, config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader:
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  # Networking:
   networking.hostName = "alex";
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [
      # 80 # nginx
      # ...
    ];
  };
  networking.networkmanager.enable = true;
  
  # Build packages in chroot:
  nix.useChroot = true;

  # Time and locale
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
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

  # X11 and desktop environment:
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    libinput.enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome.enable = true;
  };

  # Audio:
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User account:
  users.users.alex = {
    isNormalUser = true;
    description = "Alex";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  # Printing:
  services.printing.enable = true;

  # Programs:
  environment.localBinInPath = true;
  programs = {
    firefox.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar.enable = true;
  };

  # Services:
  services = {
    flatpak.enable = true;
    openssh.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
  };

  # Packages:
  environment.systemPackages = with pkgs; [
    vim git wget curl fastfetch
  ];

  # Nix settings:
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Allow unfree packages:
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
