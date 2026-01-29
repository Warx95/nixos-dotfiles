{ config, pkgs, ... }:

let
	dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
	configs = {
		qtile = "qtile";
		alacritty = "alacritty";
		rofi = "rofi";
	};
in

{
	home = {
		username = "rusantokhin";
		homeDirectory = "/home/rusantokhin";
		stateVersion = "26.05";
	};

	xdg.configFile = builtins.mapAttrs (name: subpath: {
		source = create_symlink "${dotfiles}/${subpath}";
		recursive = true;
	})
	configs;

	programs = {

		git = {
			enable = true;
			settings = {
				user = {
					name = "Ruslan Antokhin";
					email = "rusantokhin@gmail.com";
				};
				init.defaultBranch = "main";
			};
			extraConfig = {
				pull.rebase = "false";
			};
		};

		bash = {
			enable = true;
			shellAliases = {
				btw = "echo I use NixOS, btw";
			};
		};

		zed-editor = {
		    enable = true;
		    extensions = [ "nix" "toml" "yaml" ];
		};

	};
	fonts.fontconfig.enable = true;
	home.packages = with pkgs; [
		alacritty
		rofi
		firefox
		telegram-desktop
		nerd-fonts.jetbrains-mono
	];
}
