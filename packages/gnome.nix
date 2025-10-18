{ config, pkgs, ... }:

{
  # Dconf (gnome config)
  programs.dconf.enable = true;

  # Wayland
  services.gnome.gnome-keyring.enable = true;
  services.dbus.enable = true;

  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    baobab
    epiphany
    geary
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-color-manager
    gnome-connections
    gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-text-editor
    gnome-tour
    gnome-user-docs
    gnome-weather
    gnome-weather
    loupe
    nautilus
    orca
    simple-scan
    snapshot
    totem
    yelp
  ]) ++ (with pkgs.gnome; [
  ]);

}

