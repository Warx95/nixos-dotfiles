{ config, pkgs, ... }:

{
  imports = [
    ../../configuration-base.nix         # Import the shared system config
    ./hardware-configuration.nix   # Import hardware scan
  ];

  networking.hostName = "home-desktop";

  # NVIDIA Specifics (Only for this desktop)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
}
