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
    home.packages = with pkgs; [
      fastfetch
    ];

    home.shellAliases = {
      s = "fastfetch";
    };

    xdg.configFile = {
      "fastfetch/config.jsonc".source = ./config.jsonc;
      "fastfetch/ussr.png".source = ./ussr.png;
    };
  };
}
