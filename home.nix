{ config, pkgs, ... }:

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
    # llvmPackages.libcxxClang
    neofetch
    ncdu
    p7zip
    parallel
    python311
    python311Packages.ipython
    ripgrep
    rustup # overlay::rust
    # sshfs
    tree-sitter
    unixtools.xxd
    wol
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
    settings = {
      OTHER_WRITABLE = "30;46";
    };
  };

  programs.fish.enable = true;
  programs.fish.shellAbbrs = {
    ls = "lsd";
    ipy = "ipython";
  };

  programs.neovim = {
    enable = true;
    coc = {
      enable = true;
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
	" Everforest
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
	# General plugins
	barbar-nvim
	# boole # TODO: Map Ctrl-X, Ctrl-A keybinds to :Boole
	# deadcolumn doesn't have one yet
	everforest
	# hlargs doesn't have one yet
	# leap # TODO: Learn/configure
	rust-tools-nvim
	nvim-treesitter
	trim-nvim
	# no statusline.lua
	vim-illuminate
	vim-polyglot
	vim-sleuth
	nvim-web-devicons

	# Language support
	coc-clangd # overlay::c++
	coc-cmake # overlay::c++
	coc-css # overlay::css, overlay::webdev
	coc-highlight
	coc-html # overlay::webdev
	coc-json
	coc-pyright # overlay::pyright
	coc-python # overlay::python
	coc-rust-analyzer # overlay::rust
	coc-sh
	coc-toml # overlay::rust
	coc-yaml
	nvim-treesitter-parsers.bash
	nvim-treesitter-parsers.beancount
	nvim-treesitter-parsers.c
	nvim-treesitter-parsers.clojure
	nvim-treesitter-parsers.cmake
	nvim-treesitter-parsers.css
	nvim-treesitter-parsers.cpp
	nvim-treesitter-parsers.cuda
	nvim-treesitter-parsers.dockerfile
	nvim-treesitter-parsers.fish
	nvim-treesitter-parsers.gitattributes
	nvim-treesitter-parsers.gitignore
	nvim-treesitter-parsers.javascript
	nvim-treesitter-parsers.json
	nvim-treesitter-parsers.markdown
	nvim-treesitter-parsers.make # overlay::c++
	nvim-treesitter-parsers.nix
	nvim-treesitter-parsers.python # overlay::python
	nvim-treesitter-parsers.regex
	nvim-treesitter-parsers.rust # overlay::rust
	nvim-treesitter-parsers.scss # overlay::css
	nvim-treesitter-parsers.ssh_config
	nvim-treesitter-parsers.vim
	nvim-treesitter-parsers.xml
	nvim-treesitter-parsers.yaml
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
    ".config/alacritty/alacritty.yml".source = .config/alacritty/alacritty.yml;
    ".config/fontconfig/fonts.conf".source = .config/fontconfig/fonts.conf;
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

  # I'm totally not going to forget that my dconf is now partially managed and wonder why settings keep reverting...
  imports = [
    ./dconf.nix
  ];
}
