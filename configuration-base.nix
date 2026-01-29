{ config, pkgs, lib, ... }:

{
  # 1. Bootloader (Common for UEFI systems)
  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = false; # Changed to true for better management
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };

  # 2. Networking (NetworkManager is standard for desktops/laptops)
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;

  # 3. Locale & Time
  time.timeZone = "Europe/Moscow";
  
  # 4. Sound (Pipewire is recommended over PulseAudio now)
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # 5. User Account (Shell, Groups)
  users.users.rusantokhin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # 6. Common System Packages
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    micro
  ];

  # 7. Desktop Environment
  services.xserver = {
  	enable = true;
  	autoRepeatDelay = 200;
  	autoRepeatInterval = 35;
  	windowManager.qtile.enable = true;
  };
  services.displayManager.ly.enable = true;

  # 8. Nix Settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # 9. State Version
  system.stateVersion = "25.11"; 
}
