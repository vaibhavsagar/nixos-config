# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, agenix, copyparty, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      agenix.nixosModules.default
      copyparty.nixosModules.default
    ];

  # Age
  age.secrets = {
    github-access-token.file = ../secrets/github-access-token.age;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.memtest86.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "usb_storage" ];
  boot.initrd.luks.devices."luks-35e972ce-a799-4430-8d99-03370ee6513b" = {
    allowDiscards = true;
    keyFileSize = 4096;
    keyFile = "/dev/disk/by-id/usb-USB_SanDisk_3.2Gen1_05014f5388945b9a8a990577db706ffc06ba4245a2a336cec1991bcb834bb37622b600000000000000000000a04e5978009a101083558107212b3bb5-0:0";
    fallbackToPassword = true;
  };
  boot.initrd.luks.devices."luks-c14ca3aa-53c8-4069-921c-3c61d66483f6" = {
    device = "/dev/disk/by-uuid/c14ca3aa-53c8-4069-921c-3c61d66483f6";
    allowDiscards = true;
    keyFileSize = 4096;
    keyFile = "/dev/disk/by-id/usb-USB_SanDisk_3.2Gen1_05014f5388945b9a8a990577db706ffc06ba4245a2a336cec1991bcb834bb37622b600000000000000000000a04e5978009a101083558107212b3bb5-0:0";
    fallbackToPassword = true;
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "nct6775" ];

  # hardware.display.edid.packages = [
  #   (pkgs.runCommand "edid-custom" {} ''
  #     mkdir -p $out/lib/firmware/edid
  #     base64 -d > "$out/lib/firmware/edid/tcl-beyond-tv.bin" <<'EOF'
  #     AP///////wBQbFOWAAABABQhAQOAeUR4CmE1rFBEoyUPUFQhCACBQKlAgYCBwKnAAQEBAQEBCOgA
  #     MPJwWoCwWIoAuahCAAAeb8IAoKCgVVAwIDUAVlAhAAAeAAAA/ABCZXlvbmQgVFYKICAgAAAA/QAY
  #     kB+MPAAKICAgICAgA9rwAnAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
  #     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
  #     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAngIDevBQYWBmZXZfXl0/ECIfIAUUBDgPBwcVB1BX
  #     BwFnBAc9B8BffgdffgE1ByjiAMtuAwwAEAC4RCEAgAECAwRq2F3EAXiAbwIw8OMF4wHiDx/jBg8B
  #     gwEAAOUBi4SQAesBRtAATRp+ikZlhW0aAAACATDwAABgQFpEAAAAAABmcBJ5AAADATw8/gGE/w5P
  #     AAeAHwBvCJkAiwAHADeLAAR/BxcBV4ArADcELAADAAQAB+gABH8HFwFXgCsANwQsAAMABAAAAAAA
  #     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/ZA=
  #     EOF
  #   '')
  # ];
  # hardware.display.outputs."HDMI-A-2".edid = "tcl-beyond-tv.bin";
  # hardware.display.outputs."HDMI-A-2".mode = "D";

  networking.hostName = "nixos-terra"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  environment.etc."sysconfig/lm_sensors" = {
    text = ''
      HWMON_MODULES="lm78"
    '';
    mode = "0644";
    user = "root";
    group = "root";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
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
  # services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "ctrl:nocaps";
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.logitech.wireless.enable = true;
  
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaPersistenced = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "580.105.08";
      sha256_64bit = "sha256-2cboGIZy8+t03QTPpp3VhHn6HQFiyMKMjRdiV2MpNHU=";
      sha256_aarch64 = lib.fakeHash;
      openSha256 = "sha256-FGmMt3ShQrw4q6wsk8DSvm96ie5yELoDFYinSlGZcwQ=";
      settingsSha256 = "sha256-YvzWO1U3am4Nt5cQ+b5IJ23yeWx5ud1HCu1U0KoojLY=";
      persistencedSha256 = "sha256-qh8pKGxUjEimCgwH7q91IV7wdPyV5v5dc5/K/IcbruI=";
    };

  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vaibhavsagar = {
    isNormalUser = true;
    description = "Vaibhav Sagar";
    extraGroups = [ "networkmanager" "wheel" "remotebuild" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA8Ku07baZSVh7RsqD2KnKp8TflBrHB4nf7huRrhFxSj"
    ];
  };

  users.groups.remotebuild = {};

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # Install firefox.
  programs.firefox.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.bash.blesh.enable = true;
  programs.bash.completion.enable = true;

  programs.java.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    copyparty.overlays.default
  ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://ihaskell.cachix.org"
      "https://ghc-nix.cachix.org"
      "https://vaibhavsagar.cachix.org"
    ];
    trusted-public-keys = [
      "ihaskell.cachix.org-1:WoIvex/Ft/++sjYW3ntqPUL3jDGXIKDpX60pC8d5VLM="
      "vaibhavsagar.cachix.org-1:PxFckJ8oAzgF4sdFJ855Fw38yCVbXmzJ98Cc6dGzcE0="
      "ghc-nix.cachix.org-1:ziC/I4BPqeA4VbtOFpFpu6D1t6ymFvRWke/lc2+qjcg="
    ];
    build-cores = 8;
    max-jobs = "auto";
    trusted-users = [ "@wheel" "remotebuild" ];
  };

  nix.extraOptions = ''
    !include ${config.age.secrets.github-access-token.path}
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    agenix.packages.x86_64-linux.default
    atuin
    copyparty
    kdePackages.filelight
    git
    gitAndTools.diff-so-fancy
    gparted
    htop
    killall
    lm_sensors
    mangohud
    neovim
    neovim-qt
    nix-output-monitor
    powertop
    solaar
    vimHugeX
    wezterm
    wget
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
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  services.fwupd.enable = true;
  services.fstrim.enable = true;
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";
  services.speechd.enable = lib.mkForce false;

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
  system.stateVersion = "25.05"; # Did you read the comment?

}
