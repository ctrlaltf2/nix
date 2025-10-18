# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      # My laptop's specific config
      <nixos-hardware/framework/13-inch/7040-amd>
      # Then, the results of the hardware scan.
      ./hardware-configuration.nix
      # ./nixos-hardware/framework/13-inch/7040-amd/default.nix

      # system-level packages compiled from source with mtune, march
      ./packages/system/source.nix
      # system-level binary packages
      ./packages/system/binary.nix
      # firefox with pocket, etc. other crap disabled OOB
      ./packages/system/firefox.nix
      ./packages/user/binary.nix

      # TODO: rename to modules
      ./packages/gnome.nix
      ./packages/niri.nix
      ./packages/steam.nix
      ./packages/kitty.nix
      ./packages/obsidian.nix

      # services
      ./services/syncthing.nix
      ./services/opensnitch.nix
      #./services/clamav.nix

      ./users/user.nix

      # keepassxc with many unneeded features turned off
      ./packages/user/keepassxc.nix

      # No default packages
      ./nixos/no-defaults.nix

      # Hardening options
      ./hardening.nix

      # Home server wireguard configuration
      #./priv/wireguard.nix

      # hotspot+ap
      #./priv/vpn-home.nix
      #./services/hotspot.nix

      # nextdns
      #./priv/nextdns.nix
      #./priv/nextdns-doh.nix

      # sandboxed zoom (zoom-us)
      #./services/zoom.nix

      # tailscale
      ./modules/tailscale.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-fcb325f2-504d-4b99-bb71-7b89a730c4c5".device = "/dev/disk/by-uuid/fcb325f2-504d-4b99-bb71-7b89a730c4c5";
  networking.hostName = "framework"; # Define your hostname.
  
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  console.packages = with pkgs; [
    ibm-plex
  ];

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.blex-mono
  ];

  services.fwupd.enable = true;
  services.pipewire.enable = true;
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    xkb.options = "caps:escape";
  };
  ## nuke caps (sway ignores it of course but works for console)

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Electron workaround
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  # Flakes!
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow building for my CPU
  nix.settings.system-features = [ "gccarch-znver4" ];

  # GPG
  programs.gnupg.agent.enable = true;

  # Run unpatched executables (like CLion, etc)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    SDL
    SDL2
    SDL2_image
    SDL2_mixer
    SDL2_ttf
    SDL_image
    SDL_mixer
    SDL_ttf
    alsa-lib
    #at-spi2-atk
    #at-spi2-core
    atk
    bzip2
    cairo
    cups
    curlWithGnuTls
    dbus
    dbus-glib
    desktop-file-utils
    e2fsprogs
    expat
    flac
    fontconfig
    freeglut
    freetype
    fribidi
    fuse
    fuse3
    gdk-pixbuf
    glew110
    glib
    gmp
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-ugly
    gst_all_1.gstreamer
    gtk2
    harfbuzz
    icu
    keyutils.lib
    libGL
    libGLU
    libappindicator-gtk2
    libcaca
    libcanberra
    libcap
    libclang.lib
    libdbusmenu
    libdrm
    libgcrypt
    libglvnd
    libgpg-error
    libidn
    libjack2
    libjpeg
    libmikmod
    libogg
    libpng12
    libpulseaudio
    librsvg
    libsamplerate
    libthai
    libtheora
    libtiff
    libudev0-shim
    libusb1
    libuuid
    libvdpau
    libvorbis
    libvpx
    libxcrypt-legacy
    libxkbcommon
    libxml2
    mesa
    nspr
    nss
    openssl
    p11-kit
    pango
    pixman
    python3
    speex
    stdenv.cc.cc
    tbb
    udev
    vulkan-loader
    wayland
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXft
    xorg.libXi
    xorg.libXinerama
    xorg.libXmu
    xorg.libXrandr
    xorg.libXrender
    xorg.libXt
    xorg.libXtst
    xorg.libXxf86vm
    xorg.libpciaccess
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    xorg.xkeyboardconfig
    xz
    zlib
  ];

  console = {
    useXkbConfig = true;
    # Everforest
    colors = [
      "232a2e" # 0 black
      "e67e80" # 1 red
      "a7c080" # 2 green
      "dbbc7f" # 3 yellow
      "7fbbb3" # 4 blue
      "d699b6" # 5 magenta
      "83c092" # 6 cyan
      "d3c6aa" # 7 white
      "7a8478" # 8 bright black
      "e67e80" # 9 bright red
      "a7c080" # A bright green
      "dbbc7f" # B bright yellow
      "7fbbb3" # C bright blue
      "d699b6" # D bright magenta
      "83c092" # E bright cyan
      "d3c6aa" # F bright white
    ];
  };

  # programs.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true;
  #   # Installed from source by separate import
  #   # package = null;
  # };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  programs.light.enable = true;

  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   #extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };

  # Wayland::Login manager
  # services.greetd = {
  #   enable = true;
  #   settings = rec {
  #     initial_session = {
  #       command = "${pkgs.sway}/bin/sway";
  #       user = "user";
  #     };
  #     default_session = initial_session;
  #   };
  # };

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
  #networking.firewall.allowedTCPPorts = [ 25565 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;
  networking.firewall = {
    allowedTCPPorts = [
      #1776 # OSM americana
      #8080 # General
      #8443 # Unifi
      #8880 # Unifi
      #8843 # Unifi
      #25565 #minecraft
      8000 # python http
    ];
    allowedUDPPorts = [
      #3478
      #24454 # minecraft simple-voice-chat
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # Docker
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    podman-tui
    podman-compose
  ];

  # RTLSDR
  hardware.rtl-sdr.enable = true;
  users.users.user.extraGroups = [ "plugdev" ];

  # Flatpak
  services.flatpak.enable = true;

  # wheel group are trusted
  nix.settings.trusted-users = [
    "@wheel"
  ];

  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d";
  };

  nix.optimise.automatic = true;

  programs.firejail = {
    enable = true;
  };

  environment.etc."current-system-packages".text = let packages = builtins.map (p: "${p.name}") config.environment.systemPackages; sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages); formatted = builtins.concatStringsSep "\n" sortedUnique; in formatted;

  # Joycons
  services.joycond.enable = true;

    # Add Brother printer drivers
  services.printing.drivers = [
    pkgs.brlaser
    pkgs.brgenml1lpr
    pkgs.brgenml1cupswrapper
  ];
  services.printing.enable = true;
}
