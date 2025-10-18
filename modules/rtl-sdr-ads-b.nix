{ config, pkgs, lib, ... }:

{
  imports = [
    "/etc/nixos/modules/containers.nix"
  ];

  hardware.rtl-sdr = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    dump1090-fa
  ];

  users.users.user.extraGroups = [ "plugdev" ];

  users.users."ultrafeeder-agent" = {
    isNormalUser = false;
    isSystemUser = true;
    extraGroups = [
      "plugdev" # Allows access to USB devices
      "adsb-data" # Group-based management of the adsb folder data
    ];
    group = "ultrafeeder-agent";
  };
  users.groups."ultrafeeder-agent" = {};
}
