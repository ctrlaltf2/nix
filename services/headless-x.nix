{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autorun = true;
    config = {

    };

    deviceSection = ''

    '';

    display = 42;

    inputClassSections = ''

    '';

    modules = [ pkgs. ];
    moduleSection = ''

    '';
    resolutions = {

    };
    screenSection = ''

    '';
    serverFlagsSection = ''

    '';
    serverLayoutSection = ''

    '';
    tty = 5;
    virtualScreen = {

    };

    monitorSection = ''

    '';
  };
}
