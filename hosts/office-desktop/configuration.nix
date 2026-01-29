{ config, pkgs, ... }:

{
  imports = [
    ../../configuration-base.nix         # Import the shared system config
    ./hardware-configuration.nix   # Import hardware scan
  ];

  networking.hostName = "office-desktop";
}
