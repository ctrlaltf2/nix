{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.user = { pkgs, lib, ... }: {
    programs.kitty = {
      enable = true;
      font = {
        name = "BlexMono Nerd Font";
        package = pkgs.nerd-fonts.blex-mono;
      };
      shellIntegration = {
        enableBashIntegration = true;
        enableFishIntegration = true;
      };
      themeFile = "everforest_dark_medium";
    };
  };
}
