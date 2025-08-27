# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, obelisk, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../services/uptrust-cache.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-7b4f4406-801b-44e3-a9d3-36035ea12242".device = "/dev/disk/by-uuid/7b4f4406-801b-44e3-a9d3-36035ea12242";
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
  boot.kernelParams = [ "nmi_watchdog=0" ];

  networking.hostName = "nixos-l14g3"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.appendNameservers = ["100.100.100.100"];
  # networking.search = ["tail603c.ts.net"];

  hardware.bluetooth.enable = true;
  hardware.logitech.wireless.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      intel-media-sdk
      libvdpau-va-gl
      vpl-gpu-rt
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  # Set your time zone.
  # time.timeZone = "America/Chicago";
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.input-remapper.enable = true;
  services.resolved.enable = true;
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "ctrl:nocaps";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  # security.pki.certificates = [
  #   (builtins.readFile /home/vaibhavsagar/.local/share/mkcert/rootCA.pem)
  # ];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.fwupd.enable = true;
  services.fstrim.enable = true;

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "atem-udev-rules";
      text = ''SUBSYSTEM=="usb", ATTRS{idVendor}=="1edb", ATTRS{idProduct}=="be56", TAG+="uaccess"'';
      destination = "/etc/udev/rules.d/20-atem.rules";
    })
    pkgs.via
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vaibhavsagar = {
    isNormalUser = true;
    description = "Vaibhav Sagar";
    extraGroups = [ "audio" "dialout" "docker" "libvirtd" "kvm" "qemu" "networkmanager" "wheel" ];
  };

  users.groups.libvirtd.members = ["vaibhavsagar"];

  # Install firefox.
  programs.firefox.enable = true;
  programs.bash.blesh.enable = true;
  programs.bash.completion.enable = true;
  programs.kdeconnect.enable = true;
  programs.dconf.enable = true;
  programs.virt-manager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;

  nix.buildMachines = [
    {
      hostName = "100.124.243.32";
      sshUser = "vaibhavsagar";
      sshKey = "/home/vaibhavsagar/.ssh/id_ed25519";
      system = pkgs.stdenv.hostPlatform.system;
      supportedFeatures = [ "nixos-test" "big-parallel" "kvm" ];
    }
  ];

  nix.settings = {
    auto-optimise-store = true;
    substituters = [
      "https://ihaskell.cachix.org"
      "https://vaibhavsagar.cachix.org"
    ];
    trusted-public-keys = [
      "ihaskell.cachix.org-1:WoIvex/Ft/++sjYW3ntqPUL3jDGXIKDpX60pC8d5VLM="
      "vaibhavsagar.cachix.org-1:PxFckJ8oAzgF4sdFJ855Fw38yCVbXmzJ98Cc6dGzcE0="
    ];
    build-cores = 10;
    max-jobs = "auto";
    trusted-users = [ "@wheel" ];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    kdePackages.ark
    atuin
    # beekeeper-studio
    blesh
    cabal-install
    cabal2nix
    elan
    exfat
    kdePackages.filelight
    # haskellPackages.fourmolu
    gimp
    git
    gitAndTools.diff-so-fancy
    gnugrep
    gnumake
    gnupg
    google-chrome
    gparted
    haskellPackages.ghcid
    # hlint
    htop
    jack2
    jq
    kdiskmark
    krita
    monitorets
    neovim
    neovim-qt
    nix-prefetch-git
    nix-output-monitor
    ntfs3g
    (import obelisk { system = "x86_64-linux"; }).command
    obs-studio
    kdePackages.okular
    plover.dev
    powertop
    qjackctl
    ripgrep
    # ruff
    signal-desktop
    slack
    solaar
    sops
    spek
    spotify
    tmux
    tree
    tuxguitar
    unzip
    via
    vimHugeX
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    vlc
    vscode
    # wineWowPackages.staging
    # winetricks
    wezterm
    wl-clipboard
    zoom-us
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.lxc.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;
  services.spice-vdagentd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    allowedTCPPorts = [ 22 ];
    checkReversePath = "loose";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
