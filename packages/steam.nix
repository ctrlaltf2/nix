{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # steam FHS support
    steam-run
    gamescope
  ];

  programs.steam = {
    enable = true;
  };

  networking.firewall = {
    allowedTCPPorts = [
      # 27036 # steam link
      # 27037 # steam link
    ];
    allowedUDPPorts = [
      # 27031 # steam link
      # 27036 # steam link
    ];
  };
}
