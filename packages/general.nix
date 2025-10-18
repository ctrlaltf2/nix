{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> {
    config = {
      #allowUnfree = true;
    };
  };
in
{
  users.users.user = {
    packages = with pkgs; [
      #curl
      #git
      #htop
      #logseq
      #neovim
      vulnix
      xdg-user-dirs
      

      # printing software for that one company that thinks renting a printer
      # to consumers is a cool idea
      # hplip
      # hplipWithPlugin

      #unstable.jetbrains.idea-community
      #jetbrains.idea-community
      #android-studio
      #unstable.android-studio
      android-tools

      file
      htop
      signal-desktop

      ungoogled-chromium

      uv

      unstable.rust-analyzer
    ];
  };
}
