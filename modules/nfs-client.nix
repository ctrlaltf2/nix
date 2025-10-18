{ config, pkgs, lib, ... }:

{
  boot.supportedFilesystems = [ "nfs" "nfs4" ];
  boot.initrd.kernelModules = [ "nfs" "nfs4" ];
  #services.rpcbind.enable = true;

  # Working, but it does nfs3, shits the bed if file locks and insecure
  #fileSystems."/data/remote/bag" = {
  #  device = "10.0.0.110:/home/user";
  #  fsType = "nfs";
  #};

  fileSystems."/data/remote/bag" = {
    device = "${NASIP}:/home/user";
    fsType = "nfs";
    options = [ "nfsvers=4.2" ];
  };
}
