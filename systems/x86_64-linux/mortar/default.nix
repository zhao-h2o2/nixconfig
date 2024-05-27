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
      syncthing = enabled;
      clash = enabled;
    };

    cli-apps = {
      appimage-run = enabled;
      bottom = enabled;
      doas = enabled;
      git = enabled;
      http = enabled;
      neovim = enabled;
      proxychains = enabled;
      search = enabled;
      yazi = enabled;
    };

    desktop = {
      displaymanager.gdm = enabled;
      desktopenvironment.gnome = enabled;
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
    };

    apps = {
      obsidian = enabled;
      netease-music = enabled;
      zotero = enabled;
    };
  };

  services.xserver.desktopManager.gnome.enable = true;
  
  environment.systemPackages = with pkgs; [
    neovim
    gcc
    clash-meta
  ];

  system.stateVersion = "23.11";
}
