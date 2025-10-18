{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> {};
in
{
  imports = [
    <home-manager/nixos>
  ];
  
  #home-manager.useUserPackages = true;
  home-manager.users.user = { pkgs, lib, ... }: {
    # More wayland garbage
    home.sessionVariables.NIXOS_OZONE_WL = "1";

    home.packages = with pkgs; [
      fish
      git
      gcc
      neofetch
      ncdu
      p7zip
      parallel
      ripgrep
      tree-sitter
      unixtools.xxd
      wol
      dig
      easyeffects
      cargo-vet
      anki-bin
      mpv
      duckdb
    ];

    programs = {
      alacritty = {
	enable = true;
	settings = {
	  terminal.shell = "fish";
	  # Everforest (medium)
	  colors.bright = {
	    "black" = "0x475258";
	    "blue" = "0x7fbbb3";
	    "cyan" = "0x83c092";
	    "green" = "0xa7c080";
	    "magenta" = "0xd699b6";
	    "red" = "0xe67e80";
	    "white" = "0xd3c6aa";
	    "yellow" = "0xdbbc7f";
	  };
	  colors.normal = {
	    "black" = "0x475258";
	    "blue" = "0x7fbbb3";
	    "cyan" = "0x83c092";
	    "green" = "0xa7c080";
	    "magenta" = "0xd699b6";
	    "red" = "0xe67e80";
	    "white" = "0xd3c6aa";
	    "yellow" = "0xdbbc7f";
	  };
	  colors.primary = {
	    "background" = "0x2d353b";
	    "foreground" = "0xd3c6aa";
	  };
	  font.builtin_box_drawing = true;
	  font.size = 14;
	  window.padding = {
	    x = 0;
	    y = 0;
	  };
	};
      };
      bash.enable = true;
      fish.enable = true;
      fish.shellAbbrs = {
        ls = "lsd";
	ipy = "python3";
	ipython3 = "python3";
	py = "python3";
	ssh-condom = "ssh -a -i /dev/null -o IdentityAgent=/dev/null";
	zoom-us = "zoom-safe";
	zoom = "zoom-safe";
      };
      direnv = {
        enable = true;
	nix-direnv.enable = true;
      };
      eza = {
	enable = true;
	enableBashIntegration = true;
	enableFishIntegration = true;
      };
      fzf.enable = true;
      jq.enable = true;
      lsd.enable = true;
      helix = {
	enable = false;
	package = pkgs.evil-helix;
	extraPackages = with pkgs; [
	  ruff
	  uv
	  pyright
	  pylyzer
	];
	# languages.toml
	languages = {
	  language = [
	    {
	      name = "python";
	      "auto-format" = true;
	      "language-servers" = ["pyright" "ruff" "pylyzer"];
	    }
	  ];

	  language-server.pyright.config.python.analysis.typeCheckingMode = "basic";
	  language-server.ruff = {
	    command = "ruff";
	    args = ["server"];
	  };

	  language-server.pylyzer = {
	    command = "pylyzer";
	    args = ["--server"];
	  };
	};
      };
      starship.enable = true;
      tmux.enable = true;
      dircolors = {
        enable = true;
	enableFishIntegration = true;
	enableBashIntegration = true;
	settings = {
	  OTHER_WRITABLE = "30;46";
	};
      };

      neovim = {
        enable = true;
	defaultEditor = true;
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

		set mouse=

		autocmd BufNewFile,BufRead *.beancount setfiletype beancount
		autocmd BufNewFile,BufRead *.beancount TSEnable highlight

		set tabstop=2
		set softtabstop=2
		set shiftwidth=2
		set expandtab
		set number ruler
		set autoindent smartindent
		syntax enable
		filetype plugin indent on
	'';
	extraLuaConfig = ''
	  vim.opt.hlsearch = true
	  vim.opt.number = true
	  vim.opt.mouse = ""
	  vim.opt.spelllang = "en_us"
	  vim.opt.title = true

	  vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
	  vim.opt.undofile = true


	  vim.lsp.config('ty', {
	    cmd={"ty", "server"},
	    filetypes={"python"},
	    root_markeres={"ty.toml", "pyproject.toml", ".git"}
	  })
	  -- vim.lsp.enable('ty')

	  vim.lsp.enable('basedpyright')
	  vim.lsp.enable('ruff')
	  -- vim.lsp.enable('pylyzer')

	  vim.lsp.inlay_hint.enable(true)
	'';
	extraPackages = with pkgs; [
	  # ty
	  basedpyright
	  ruff
	];
	plugins = with pkgs.vimPlugins; [
	  # barbar-nvim
	  everforest
	  # rust-tools-nvim
	  nvim-treesitter
	  # trim-nvim
	  vim-illuminate
	  vim-polyglot
	  vim-sleuth
	  # nvim-web-devicons
	  # vimtex

	  rustaceanvim

	  coc-clangd
	  coc-cmake
	  coc-css
	  coc-highlight
	  coc-html
	  coc-rust-analyzer
	  coc-sh
	  coc-toml
	  coc-yaml
          nvim-treesitter-parsers.bash
	  nvim-treesitter-parsers.beancount
	  nvim-treesitter-parsers.c
	  nvim-treesitter-parsers.clojure
	  nvim-treesitter-parsers.cmake
	  nvim-treesitter-parsers.css
	  #nvim-treesitter-parsers.cpp
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
	  nvim-lspconfig
	];
	withNodeJs = true;
	withPython3 = true;
      };
      git = {
        enable = true;
	userName = "ctrlaltf2";
	userEmail = "23644849+ctrlaltf2@users.noreply.github.com";
	lfs = {
	  enable = true;
	};
	extraConfig = {
	  safe.directory = "/etc/nixos";
	};
	delta = {
	  enable = true;
	};
      };
      home-manager.enable = true;
      zoxide = {
	enable = true;
	enableFishIntegration = true;
      };
      # from https://codeberg.org/fizzyizzy05/dotfiles/src/commit/eaeba7c70dfadbd2021c4e58cea6572031eab020/config/waybar/config.jsonc
      waybar = {
	enable = true;
	settings = {
	  mainBar = {
	    layer = "top";
	    modules-left = [
	      #"sway/workspaces"
	      "niri/workspaces"
	      "niri/window"
	      "sway/mode"
	    ];
	    modules-center = ["clock"];
	    modules-right = [
	      "tray"
	      "sway/scratchpad"
	      "battery"
	      "cpu"
	      "memory"
	    ];
	    "niri/workspaces" = {
	      format = "{index}";
	    };
	    clock = {
	      format = "{:%F %R %z}";
	      interval = 60;
	      tooltip-format = "{:%a, %b %e %Y}";
	    };
	    tray = {
	      spacing = 12;
	    };
	    memory = {
	      format = "  {percentage}%";
	      interval = 4;
	    };
	    cpu = {
	      format = "  {usage}%";
	      interval = 4;
	    };
	    battery = {
	      format = "{icon} {capacity}%";
	      format-charging = "{icon} {capacity}% ";
	      format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
	      interval = 30;
	    };
	  };
	};
	style = ''
	  window#waybar {
	    background-color: rgba(25, 23, 36, 0.75);
	    color: #cdd6f4;
	    transition-property: background-color;
	    transition-duration: .5s;
	    border-bottom: 1px solid rgba(144, 140, 170, 0.35);
	  }

	  * {
	    font-family: "DejaVu Sans Mono";
	    font-size: 10pt;
	  }

	  #workspaces button {
	    padding-top: 4px;
	    padding-bottom: 4px;
	    padding-left: 8px;
	    padding-right: 8px;
	    background-color: transparent;
	    border-radius: 100%;
	    border: 6px #f5c2e7;
	    font-weight: 800;
	    color: #a6adc8; 
	  }

	  #workspaces button.urgent {
	    color: #fab387;
	  }

	  #workspaces button:hover {
	    background: rgba(69, 71, 90, 0.65);
	    color: #cdd6f4;
	    border: 12px #f5c2e7;
	    transition: none;
	  }

	  #workspaces button.focused {
	    color: #f5c2e7;
	    border: 12px #f5c2e7;
	  }

	  label.module {
	    padding: 0 10px 0 10px;
	  }

	  box.module button:hover {
	    box-shadow: none;
	    outline: none;
	    font-style: normal;
	    text-shadow: none;
	  }

	  #tray {
	    padding: 0 8 0 8;
	  }

	  menu {
	    background-color: #181825;
	    color: #cdd6f4;
	    border: 1px solid #494d64;
	    padding: 6px;
	    border-radius: 12px;
	  }

	  #tray menu menuitem:hover {
	    background-color: #1e1e2e;
	    color: #f5c2e7;
	    border-radius: 5px;
	  }

	  #window {
	    font-weight: 800;
	    padding: 0px 8px 0px 8px;
	  }
	'';
      };

      taskwarrior = {
	enable = false;
	package = pkgs.taskwarrior3;
	config = {
	  uda.est.type = "numeric";
	  uda.est.label = "Est (h)";
	  report.next.sort = "urgency-,est+";
	  urgency.uda.est."0".coefficient    = 5;
	  urgency.uda.est."0.25".coefficient = 4.5;
	  urgency.uda.est."0.5".coefficient  = 4.0;
	  urgency.uda.est."1".coefficient    = 3.5;
	  urgency.uda.est."2".coefficient    = 3.0;
	  urgency.uda.est."4".coefficient    = 2.5;
	  urgency.uda.est."8".coefficient    = 2.0;
	  urgency.uda.est."16".coefficient   = 1.5;
	  urgency.uda.est."32".coefficient   = 1.0;
	  urgency.uda.est."64".coefficient   = 0.5;

	  urgency.user.project.organization.coefficient = 10;
	  urgency.user.project.life.coefficient = 9.5;
	  urgency.user.project.health.coefficient = 9.0;
	  urgency.user.project.jobs.coefficient = 8.5;
	  urgency.user.project.finance.coefficient = 8.0;
	  urgency.user.project.website.coefficient = 7.5;
	  urgency.user.project.career.coefficient = 7.0;
	  urgency.user.project.homelab.coefficient = 6.5;
	  urgency.user.project.spanish.coefficient = 5.0;
	  urgency.user.project.osm.coefficient = 4.0;
	  urgency.user.project.oss.coefficient = 3.0;
	  
	  urgency.blocked.coefficient = -15.0;
	};
	dataLocation = "/home/user/Documents/PKMv2/taskwarrior";
      };
    };
  
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "25.05";

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    services.opensnitch-ui.enable = true;

    # Manage XDG base directory vars
    xdg.enable = true;
  };

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
