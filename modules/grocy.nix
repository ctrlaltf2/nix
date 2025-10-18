{ config, pkgs, lib, ... }:

{
  services.grocy = {
    enable = true;
    hostName = "${hostname}.${tailnet_id}.ts.net";
    nginx.enableSSL = false;
    settings = {
      calendar = {
        firstDayOfWeek = 1;
        showWeekNumber = false;
      };
      culture = "en";
      currency = "USD";
    };
  };

  # TODO: enable HTTPs via this
  services.nginx.virtualHosts."${hostname}.${tailnet_id}.ts.net".listen = [
    {
      addr = "${hostname}.${tailnet_id}.ts.net";
      port = 6969;
    }
  ];
}
