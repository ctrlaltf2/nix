{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.clamav
  ];

  services.clamav = {
    daemon.enable = true;
    fangfrisch.enable = true;
    scanner.enable = true;
    updater.enable = true;
  };
}
