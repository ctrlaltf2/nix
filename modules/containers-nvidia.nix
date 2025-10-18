{ config, pkgs, lib, ... }:

{
  imports = [
    "/etc/nixos/modules/containers.nix"
  ];

  hardware.nvidia-container-toolkit = {
    enable = true;
  };
}
