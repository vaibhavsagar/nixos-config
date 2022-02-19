# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };

  boot.kernelModules = [ "aesni-intel" "snd-seq" "snd-rawmidi" ];
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
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

  hardware.bluetooth.enable = true;
  # For joycontrol only
  hardware.bluetooth.disabledPlugins = [ "input" "sap" "avrcp" ];

  networking.hostName = "nixos-t480"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  nix = {
    autoOptimiseStore = true;
    binaryCaches = [
      "https://cache.nixos.org"
      "https://nixcache.reflex-frp.org"
      "https://vaibhavsagar.cachix.org"
      "https://ihaskell.cachix.org"
      "https://hydra.iohk.io"
    ];
    binaryCachePublicKeys = [
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      "vaibhavsagar.cachix.org-1:PxFckJ8oAzgF4sdFJ855Fw38yCVbXmzJ98Cc6dGzcE0="
      "ihaskell.cachix.org-1:WoIvex/Ft/++sjYW3ntqPUL3jDGXIKDpX60pC8d5VLM="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
    buildCores = 4;
    maxJobs = "auto";
    trustedUsers = [ "@wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.bash.enableCompletion = true;

  programs.ssh = {
    extraConfig = ''
      Host eu.nixbuild.net
        PubkeyAcceptedKeyTypes ssh-ed25519
        IdentityFile /home/vaibhavsagar/.ssh/my-nixbuild-key
    '';

    knownHosts = {
      nixbuild = {
        hostNames = [ "eu.nixbuild.net" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
      };
    };
  };

  powerManagement.powertop.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.xkbOptions = "ctrl:nocaps";
  services.xserver.libinput.enable = true;
  services.xserver.digimend.enable = true;
  services.xserver.inputClassSections = [
    ''
      Identifier "XP-Pen 10 inch PenTablet"
      MatchUSBID "28bd:0905"
      MatchIsTablet "on"
      MatchDevicePath "/dev/input/event*"
      Driver "wacom"
    ''
    ''
      Identifier "XP-Pen 10 inch PenTablet"
      MatchUSBID "28bd:0905"
      MatchIsKeyboard "on"
      MatchDevicePath "/dev/input/event*"
      Driver "libinput"
    ''
  ];

  services.udev.extraHwdb = ''
    evdev:input:b0003v28BDp0905e0100-e0*
      KEYBOARD_KEY_d0045=0x14c
  '';

  services.openssh.enable = true;

  services.tailscale = {
    enable = true;
    # package = pkgs.callPackage ../packages/tailscale.nix {};
  };

  services.fwupd.enable = true;
  services.fstrim.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vaibhavsagar = {
    home = "/home/vaibhavsagar";
    isNormalUser = true;
    extraGroups = [ "audio" "dialout" "docker" "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
    uid = 1000;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    gitAndTools.diff-so-fancy
    git-crypt
    gparted
    gnugrep
    gnumake
    gnupg
    google-chrome
    # haskell-language-server
    hlint
    htop
    jack2Full
    jq
    keybase
    krita
    spek
    steam
    steam-run-native
    # nixops
    nix-prefetch-git
    ntfs3g
    okular
    powertop
    parted
    partition-manager
    plover.dev
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

  virtualisation.docker.enable = true;
  virtualisation.lxc.enable = true;

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
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

