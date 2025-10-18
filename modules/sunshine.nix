{ config, pkgs, lib, ... }:

let
    pkgs = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/2042e66898343fc14582de9f4f834ae825b9c3ce.tar.gz";
    }) {};

    pkgsFixedMiniupnpc = pkgs.miniupnpc;
in
{
  services.sunshine = {
    autoStart = true;
    capSysAdmin = true;
    enable = false;
    package = (pkgs.sunshine.override { miniupnpc = pkgsFixedMiniupnpc; });
    openFirewall = true;
  };
}
