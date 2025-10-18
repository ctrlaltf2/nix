{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "zoom-us"
    ];

  users.users.user = {
    packages = with pkgs; [
      zoom-us
      firejail
    ];
  };

  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      zoom-safe = {
        executable = "${pkgs.zoom-us}/bin/zoom";
        profile = "${pkgs.firejail}/etc/firejail/zoom.profile";
      };
    };
  };

}
