# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      per-window = false;
      xkb-options = [ "caps:escape" ];
    };

    "org/gnome/desktop/interface" = {
      enable-hot-corners = true;
      font-antialiasing = "rgba";
      font-hinting = "full";
    };

    "org/gnome/desktop/privacy" = {
      report-technical-problems = false;
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      focus-mode = "click";
    };

    "org/gnome/mutter" = {
      edge-tiling = true;
    };

    "org/gnome/nautilus/compression" = {
      default-compression-format = "7z";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      terminal = [ "<Super>Return" ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-fixed = false;
      extend-height = false;
      intellihide = true;
      manualhide = false;
    };

    "org/gnome/shell/extensions/pop-cosmic" = {
      overlay-key-action = "WORKSPACES";
    };

    "org/gnome/shell/extensions/pop-shell" = {
      tile-by-default = false;
      tile-enter = [ "<Shift><Super>Return" ];
    };

    "org/gnome/system/location" = {
      enabled = false;
    };

  };
}
