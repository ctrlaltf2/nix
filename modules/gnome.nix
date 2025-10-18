{ config, lib, pkgs, ... }:

{
  # Gnome
  ## Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
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
    loupe
    orca
    simple-scan
    snapshot
    totem
    yelp
  ]) ++ (with pkgs.gnome; [
  ]);

  programs.dconf.enable = true;
}
