# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      # ./../services/dnscrypt-proxy2.nix
      # ./../services/redshift.nix
      # ./../services/zerotierone.nix
      ./../services/openvpn-keyme.nix
    ];

  boot = {
    initrd.luks.devices = {
      root = {
        device = "/dev/sda3";
        preLVM = true;
      };
    };

    kernelModules = [ "aesni-intel" "snd-seq" "snd-rawmidi" ];

    loader = {
      efi.canTouchEfiVariables = true;
      grub.device = "/dev/sda";
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
    };

    supportedFilesystems = [ "exfat" ];
  };

  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
    support32Bit = true;
    zeroconf = {
      discovery.enable = true;
      publish.enable = true;
    };
  };

  hardware.opengl = {
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };

  hardware.bluetooth.enable = true;

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
  # time.timeZone = "America/New_York";
  time.timeZone = "Australia/Sydney";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    ark
    cabal-install
    cabal2nix
    firefox
    pkgs.haskellPackages.ghcid
    pkgs.haskellPackages.hlint
    filelight
    gimp
    git
    git-crypt
    gparted
    gnugrep
    gnumake
    gnupg
    google-chrome
    haskell-language-server
    hlint
    htop
    jack2Full
    jq
    keybase
    steam
    steam-run-native
    # nixops
    nix-prefetch-git
    ntfs3g
    okular
    powertop
    parted
    partition-manager
    psensor
    qjackctl
    redir
    signal-desktop
    spotify
    tmux
    tree
    tuxguitar
    unzip
    vimHugeX
    vlc
    vscodium
    wget
    zoom-us
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.

  services = {
    avahi.enable = true;
    openssh.enable = true;
    printing.enable = true;
    printing.drivers = [ pkgs.gutenprint ];
    tailscale.enable = true;
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      layout = "us";
      xkbOptions = "ctrl:nocaps";

      # Enable the KDE Desktop Environment.
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;

      libinput.enable = true;
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
    binaryCaches = [
      "https://cache.nixos.org"
      "https://nixcache.reflex-frp.org"
      "https://vaibhavsagar.cachix.org"
      "https://ihaskell.cachix.org"
    ];
    binaryCachePublicKeys = [
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      "vaibhavsagar.cachix.org-1:PxFckJ8oAzgF4sdFJ855Fw38yCVbXmzJ98Cc6dGzcE0="
      "ihaskell.cachix.org-1:WoIvex/Ft/++sjYW3ntqPUL3jDGXIKDpX60pC8d5VLM="
    ];
    buildCores = 2;
    maxJobs = "auto";
    trustedUsers = [ "@wheel" ];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  programs.bash.enableCompletion = true;

  powerManagement.powertop.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.vaibhavsagar = {
    home = "/home/vaibhavsagar";
    extraGroups = [ "audio" "docker" "networkmanager" "wheel" ];
    isNormalUser = true;
    uid = 1000;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "19.03";

  virtualisation.docker.enable = true;
  virtualisation.lxc.enable = true;

  # virtualisation.virtualbox = {
  #   host.enable = true;
  # };

}
