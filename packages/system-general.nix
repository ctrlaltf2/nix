{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    wl-clipboard
    libglvnd
    htop

    # Fonts
    atkinson-hyperlegible
    ibm-plex

    # home-manager does not work with pulling in these dependencies, apparently
    python313
    python313Packages.psutil
    python313Packages.tasklib
  ];
}
