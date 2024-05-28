{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.fastfetch;
in {
  options.${namespace}.cli-apps.fastfetch = {
    enable = mkEnableOption "fastfetch";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fastfetch
    ];

    plusultra.home.extraOptions = {
      home.shellAliases = {
        s = "fastfetch";
      };
    };

    plusultra.home.configFile = {
      "fastfetch/config.jsonc".source = ./config.jsonc;
      "fastfetch/ussr.png".source = ./ussr.png;
    };
  };
}
