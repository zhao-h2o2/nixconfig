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
  cfg = config.${namespace}.cli-apps.search;
in {
  options.${namespace}.cli-apps.search = with types; {
    enable = mkBoolOpt false "Whether or not to enable search utils.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fzf
      ripgrep
    ];
  };
}
