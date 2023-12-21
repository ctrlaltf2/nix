# Nix
Nix files for managing nix installs (and in the future, development environments and hopefully the OS itself). Basis is Nix 23.11.

## Setup (Nix)
Mostly for my own sanity:
 - Install nix via https://github.com/DeterminateSystems/nix-installer
   - Script handles SELinux shenanigans on Fedora etc., and installs a newer version than OS package managers usually can
 - Add nixpkgs `nix-channel --add https://channels.nixos.org/nixos-23.11 nixpkgs`
 - Home-manager setup:
  - `nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager`
  - `nix-channel --update`
  - `nix-shell '<home-manager>' -A install`
- Create a link such that `$HOME/.config/home-manager/home.nix` points to `home.nix` in this repo
- `home-manager switch`
