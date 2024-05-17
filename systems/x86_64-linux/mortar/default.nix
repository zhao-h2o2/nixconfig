{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ];

  plusultra = {
    nix = enabled;

    system = {
      boot = enabled;
      fonts = enabled;
      locale = enabled;
      time = enabled;
      xkb = enabled;
      zfs = enabled;
    };

    hardware = {
      audio = enabled;
      networking = enabled;
      storage = enabled;
    };

    cli-apps = {
      neovim = enabled;
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  environment.systemPackages = with pkgs; [
    firefox
    google-chrome
    alacritty
    neovim
    gcc
    yazi
    git
    gitflow
    gitui
    lazygit
    clash-meta
    wget
    curl
  ];

  system.stateVersion = "23.11";
}
