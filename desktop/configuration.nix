# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./../services/dnscrypt-proxy.nix
      ./../services/keybase.nix
      ./../services/redshift.nix
      ./../services/zerotierone.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    ark
    cabal2nix
    cifs-utils
    dropbox
    filelight
    firefox-beta-bin
    gimp
    gitFull
    gnugrep
    gnumake
    google-chrome
    htop
    jq
    keybase
    keybase-gui
    krename
    nix-prefetch-git
    okular
    powertop
    psensor
    spek
    thunderbird
    tmux
    tree
    unzip
    vimHugeX
    vlc
    wget
  ];

  fonts.fonts = with pkgs; [
    noto-fonts-emoji
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  hardware.bumblebee.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = true;

  nix = {
    autoOptimiseStore = true;
    binaryCaches = [ "https://cache.nixos.org" "https://nixcache.reflex-frp.org" ];
    trustedBinaryCaches = [ "http://128.199.234.106:3000" ];
    binaryCachePublicKeys = [
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      "128.199.234.106:jzUyrIQHov5i6f94jQVriqPDLuPYlZPAsga3W3k+L8E="
    ];
    buildCores = 4;
    maxJobs = lib.mkForce 4;
  };

  powerManagement.powertop.enable = true;

  # Enable the X11 windowing system.
  services = {
    openssh.enable = true;
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      layout = "us";
      xkbOptions = "ctrl:nocaps";

      # Enable the KDE Desktop Environment.
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;

      synaptics = {
        enable = true;
        accelFactor = "0.01";
        minSpeed = "0.8";
        twoFingerScroll = true;
        palmDetect = true;
      };
    };
  };

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
  users.extraUsers.root.initialHashedPassword = "";
  users.extraUsers.vaibhavsagar = {
    home = "/home/vaibhavsagar";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    isNormalUser = true;
    uid = 1000;
  };

  virtualisation.docker.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
