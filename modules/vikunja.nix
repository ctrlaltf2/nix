{ config, lib, pkgs, ... }:

{
  services.vikunja = {
    enable = true;
    database.type = "sqlite";
    frontendScheme = "http";
    frontendHostname = "${hostname}.${tailnet_id}.ts.net";
  };
}
