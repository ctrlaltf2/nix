{ config, pkgs, lib, ... }:

{
  services.keycloak = {
    enable = true;
  };
}
