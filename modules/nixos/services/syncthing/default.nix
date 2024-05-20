{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let 
  cfg = config.plusultra.services.syncthing;
  name = config.plusultra.user.name;
in
{
  options.plusultra.services.syncthing = with types; {
    enable = mkBoolOpt false "Whether to enable Syncthing.";
  };

  config = mkIf cfg.enable {
    services.syncthing = rec {
      enable = true;
      overrideFolders = false;
      overrideDevices = false;
      openDefaultPorts = true;
      user = name;
      configDir = "/home/${name}/.config/syncthing";
      dataDir = "/home/${name}/.local/share/syncthing";
    };
  };
}
