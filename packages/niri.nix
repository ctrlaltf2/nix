{ config, pkgs, lib, ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  programs.niri = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    xdg-utils
    fuzzel
    swaylock
    nautilus
    xwayland-satellite
  ];

  # Merged in from https://github.com/sodiboo/niri-flake/blob/main/flake.nix
  xdg = {
    autostart.enable = true;
    menus.enable = true;
    mime.enable = true;
    icons.enable = true;
  };

  hardware.graphics.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  systemd.user.services.niri-flake-polkit = {
    description = "PolicyKit Authentication Agent provided by niri-flake";
    wantedBy = ["niri.service"];
    after = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  security.pam.services.swaylock = {};
  programs.dconf.enable = true;

  # services.evdevremapkeys = {
  #   enable = true;
  # };

  services.evremap = {
    enable = true;
    settings = {
      device_name = "AT Translated Set 2 keyboard";
      remap = [
        {
          input = [
            "KEY_CAPSLOCK"
          ];
          output = [
            "KEY_ESC"
          ];
        }
      ];
    };
  };

}
