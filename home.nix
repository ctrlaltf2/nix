{ config, pkgs, ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    dconf
    git
    htop
    neofetch
    p7zip
  ];

  programs.bat.enable = true;
  programs.direnv.enable = true;
  programs.fzf.enable = true;
  programs.jq.enable = true;
  programs.lsd.enable = true;
  programs.starship.enable = true;
  programs.tmux.enable = true;

  programs.dircolors = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.fish.enable = true;
  programs.fish.shellAbbrs = {
    ls = "lsd";
  };

  programs.neovim = {
    enable = true;
    # TODO: all of the rest
  };

  programs.git = {
    enable = true;
    userName = "ctrlaltf2";
    userEmail = "github@troyer.dev";
    lfs = {
      enable = true;
    };
  };


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
