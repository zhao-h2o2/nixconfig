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
  cfg = config.${namespace}.desktop.displaymanager.gdm;
in {
  options.${namespace}.desktop.displaymanager.gdm = with types; {
    enable =
      mkBoolOpt false "Whether or not to use Gnome as the desktop environment.";
    suspend =
      mkBoolOpt true "Whether or not to suspend the machine after inactivity.";
  };

  config = mkIf cfg.enable {
    systemd.services.plusultra-user-icon = {
      before = ["display-manager.service"];
      wantedBy = ["display-manager.service"];

      serviceConfig = {
        Type = "simple";
        User = "root";
        Group = "root";
      };

      script = ''
        config_file=/var/lib/AccountsService/users/${config.${namespace}.user.name}
        icon_file=/run/current-system/sw/share/plusultra-icons/user/${config.${namespace}.user.name}/${config.${namespace}.user.icon.fileName}

        if ! [ -d "$(dirname "$config_file")"]; then
          mkdir -p "$(dirname "$config_file")"
        fi

        if ! [ -f "$config_file" ]; then
          echo "[User]
          Session=gnome
          SystemAccount=false
          Icon=$icon_file" > "$config_file"
        else
          icon_config=$(sed -E -n -e "/Icon=.*/p" $config_file)

          if [[ "$icon_config" == "" ]]; then
            echo "Icon=$icon_file" >> $config_file
          else
            sed -E -i -e "s|^Icon=.*$|Icon=$icon_file|" $config_file
          fi
        fi
      '';
    };

    services.xserver = {
      enable = true;

      displayManager.gdm = {
        enable = true;
        wayland = true;
        autoSuspend = cfg.suspend;
      };
    };
  };
}
