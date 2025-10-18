{ config, lib, pkgs, ... }:

{
  # https://github.com/tailscale/tailscale/issues/4254
  services.resolved.enable = true;

  services.tailscale = {
    enable = true;
    extraDaemonFlags = [ "--no-logs-no-support" ];
  };

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    #allowedUDPPorts = [ config.services.tailscale.port ];
  };

  # Fix exit nodes
  networking.firewall.checkReversePath = "loose";
}
