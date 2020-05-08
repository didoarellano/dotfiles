# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  swapDevices = [
    { device = "/home/swap"; }
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };  
  };

  networking = {
    hostName = "tattletale";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Manila";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pavucontrol
    patchelf
    pciutils
    busybox
    vim
    curl
    tree
    gitFull
    fish
    firefox
    usbutils
    networkmanagerapplet
    virtmanager
    exfat-utils
    fuse_exfat
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.gnupg.agent.enable = true;
  programs.fish.enable = true;
  programs.ssh.startAgent = true;
  # programs.adb.enable = true;

  # List services that you want to enable:
  services.mysql = {
    enable = true;
    package = pkgs.mysql55;
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    24800 # synergy
  ];

  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.fstrim.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";
  services.xserver.inputClassSections = [''
    Identifier "SMK-88"
    MatchIsKeyboard "on"
    MatchUSBID "058f:9472"
    Option "XkbOptions" "ctrl:nocaps,altwin:swap_alt_win"
  ''];
  # Having issues waking from sleep. Try different drivers.
  # If problem persists with "ati", try "ati_unfree"
  # Default is already ["ati" "cirrus" "intel" ...]. Let's try anyway.
  # Can't build ati_unfree
  services.xserver.videoDrivers = ["ati" "intel"];

  services.xserver.displayManager.lightdm.enable = true;

  services.xserver.xrandrHeads = [
    { output = "DVI-D-1"; }
    { output = "HDMI-2"; primary = true; }
  ];

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  fonts = {
    fonts = with pkgs; [
      fira-mono
      fira-code
      fira-code-symbols
      roboto
      roboto-slab
      # google-fonts
      noto-fonts
      noto-fonts-emoji
      source-sans-pro
      liberation_ttf
    ];
    fontconfig = {
      enable = true;
      ultimate.enable = true;
      defaultFonts = {
        monospace = ["Fira Mono Medium"];
        sansSerif = ["Source Sans Pro"];
      };
    };
  };

  virtualisation.virtualbox = {
    guest.enable = true;
    host.enable = true;
    host.enableExtensionPack = true;
  };

  virtualisation.libvirtd.enable = true;

  virtualisation.docker.enable = true;

  users.users.dido = {
    isNormalUser = true;
    description = "Dido	Arellano";
    shell = pkgs.fish;
    extraGroups = ["wheel" "networkmanager" "adbusers" "libvirtd" "docker"];
  };

  # nix.allowedUsers = ["dido"];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}


