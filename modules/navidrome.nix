{ config, lib, pkgs, ... }:

{
  services.navidrome = {
    enable = true;
    openFirewall = true;
    user = "navidrome";
    settings = {
      MusicFolder = "/data/d0/Music";
      #  TODO: conditional on tailscale include
      Address = "<tailscale>.ts.net";
      EnableInsightsCollector = false;
      LastFM.Enabled = false;
      # TODO: Use Maloja
      ListenBrainz.Enabled = false;
    };
  };

  users.users.navidrome = {
    isNormalUser = false;
    extraGroups = [ "music" ];
  };
}
