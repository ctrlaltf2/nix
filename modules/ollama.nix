{ config, pkgs, lib, ... }:

{
  services.open-webui = {
    enable = true;
  };

  services.ollama = {
    enable = true;
    loadModels = [
      
    ];
    acceleration = "cuda";
  };
}
