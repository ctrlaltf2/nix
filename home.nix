{ config, pkgs, ... }:

/*
let
  buildTimeResponse = (builtins.fetchurl "https://currentmillis.com/time/seconds-since-unix-epoch.php");
  buildHash = (builtins.hashFile "sha256" buildTimeResponse); # hash to prevent vimscript injection
in
*/
{
  home.username = "user";
  home.homeDirectory = "/home/user";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    black # overlay::python
    dconf
    git
    htop
    neofetch
    p7zip
    ripgrep
  ];

  programs.bat.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
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
    coc = {
	enable = true;
	/* Why does this have to run every time?
	pluginConfig = builtins.replaceStrings ["{buildHash}"] [buildHash] ''
		autocmd User CocNvimInit execute ['CocInstall -sync coc-cmake coc-css coc-docker coc-git coc-highlight coc-html coc-json coc-python coc-pyright coc-toml coc-yaml', 'autocmd!']
	'';
	*/
	settings = {
		coc.preferences.formatOnType = true;
		coc.preferences.formatOnSaveFiletypes = [
			"python" # overlay::python
			"rust" # overlay::rust
		];
		codeLens.enable = true;
		colors.enable = true;
		python.formatting.provider = "black"; # overlay::python
		python.linting.flake8Enabled = true; # overlay::python
	};
    };
    # TODO: Move this to a file
    extraConfig = ''
        if has('termguicolors')
          set termguicolors
        endif

        " For dark version.
        set background=dark

        " Set contrast.
        " This configuration option should be placed before `colorscheme everforest`.
        " Available values: 'hard', 'medium'(default), 'soft'
        let g:everforest_background = 'medium'

	" Disabled atm because nix-managed neovim gets mad about file permissions or something idk
	" let g:everforest_better_performance = 1

        colorscheme everforest
    '';
    plugins = with pkgs.vimPlugins; [
    	everforest
    ];
    withNodeJs = true;
    withPython3 = true;
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
