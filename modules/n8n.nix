{ config, lib, pkgs, ... }:

{
  services.n8n = {
    enable = true;
    settings = {};
  };

  systemd.services.n8n.serviceConfig.ProtectHome = "tmpfs";
  systemd.services.n8n.serviceConfig.BindPaths = "/home/user/n8n";
}
