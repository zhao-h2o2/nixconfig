{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.desktopenvironment.gnome;

  defaultExtensions = with pkgs.gnomeExtensions; [
    appindicator
    aylurs-widgets
    dash-to-dock
    emoji-selector
    gsconnect
    gtile
    just-perfection
    logo-menu
    no-overview
    remove-app-menu
    space-bar
    top-bar-organizer
    wireless-hid
  ];

  default-attrs = mapAttrs (key: mkDefault);
  nested-default-attrs = mapAttrs (key: default-attrs);
in {
  options.${namespace}.desktop.desktopenvironment.gnome = with types; {
    enable =
      mkBoolOpt false "Whether or not to use Gnome as the desktop environment.";
    extensions = mkOpt (listOf package) [] "Extra Gnome extensions to install.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        wl-clipboard
        gnome.gnome-tweaks
        gnome.nautilus-python
      ]
      ++ defaultExtensions
      ++ cfg.extensions;

    environment.gnome.excludePackages = with pkgs.gnome; [
      pkgs.gnome-tour
      epiphany
      geary
      gnome-font-viewer
      gnome-system-monitor
      gnome-maps
    ];

    # Required for app indicators
    services.udev.packages = with pkgs; [gnome3.gnome-settings-daemon];

    services.xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
