# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./../packages/ghcid.nix
      ./../packages/hlint.nix
      # ./../services/dnscrypt-proxy.nix
      ./../services/redshift.nix
      ./../services/zerotierone.nix
    ];

  boot = {
    initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/sda3";
        preLVM = true;
      }
    ];

    loader = {
      efi.canTouchEfiVariables = true;
      grub.device = "/dev/sda";
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
    };
  };

  hardware.pulseaudio.enable = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    ark
    cabal-install
    cabal2nix
    firefox-beta-bin
    gimp
    git
    git-crypt
    gnugrep
    gnumake
    gnupg
    google-chrome
    htop
    jq
    keybase
    nixops
    nix-prefetch-git
    okular
    powertop
    psensor
    stack
    tmux
    tree
    unzip
    vimHugeX
    wget
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.

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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.networkmanager.enable = true;

  nix = {
    autoOptimiseStore = true;
    binaryCaches = [ "https://cache.nixos.org" "https://nixcache.reflex-frp.org" "http://128.199.234.106:3000" "https://vaibhavsagar.cachix.org" ];
    binaryCachePublicKeys = [
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      "vaibhavsagar.cachix.org-1:PxFckJ8oAzgF4sdFJ855Fw38yCVbXmzJ98Cc6dGzcE0="
      "128.199.234.106:jzUyrIQHov5i6f94jQVriqPDLuPYlZPAsga3W3k+L8E="
    ];
    buildCores = 2;
    trustedUsers = [ "@wheel" ];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  programs.bash.enableCompletion = true;

  powerManagement.powertop.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.vaibhavsagar = {
    home = "/home/vaibhavsagar";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    isNormalUser = true;
    uid = 1000;
  };

  users.extraUsers.vaibhavsagar-work = {
    home = "/home/vaibhavsagar-work";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    isNormalUser = true;
    uid = 1001;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";

  virtualisation.docker.enable = true;

  # virtualisation.virtualbox = {
  #   host.enable = true;
  # };

}
