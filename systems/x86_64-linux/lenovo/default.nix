{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ];

  plusultra = {
    nix = enabled;
    nix-cache = enabled;

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

    services = {
      openssh = enabled;
    };

    cli-apps = {
      appimage-run = enabled;
      bottom = enabled;
      direnv = enabled;
      doas = enabled;
      git = enabled;
      http = enabled;
      neovim = enabled;
      proxy = enabled;
      yazi = enabled;
    };

    desktop = {
      terminal = {
        wezterm = enabled;
      };
      browser = {
        vivaldi = {
          enable = true;
          default = true;
        };
        firefox = enabled;
        chrome = enabled;
      };
      inputmethod = {
        rime = enabled;
      };
      filemanager = {
        nautilus = enabled;
      };
      gtk = enabled;
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  environment.systemPackages = with pkgs; [
    neovim
    gcc
    clash-meta
  ];

  system.stateVersion = "23.11";
}
