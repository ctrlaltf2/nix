{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "obsidian"
  ];

  users.users.user = {
    packages = with pkgs; [
      obsidian
    ];
  };
}
