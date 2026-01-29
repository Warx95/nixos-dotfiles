{ config, pkgs, ... }:

{
	imports = [ ../../home-base.nix ];
	
	home.packages = with pkgs; [];
	home.stateVersion = "26.05";
}
