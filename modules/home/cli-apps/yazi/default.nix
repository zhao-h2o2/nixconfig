inputs @ {
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.cli-apps.yazi;
in {
  options.plusultra.cli-apps.yazi = with types; {
    enable = mkBoolOpt false "Whether or not to enable yazi.";
  };

  config = mkIf cfg.enable {
    xdg.configFile."yazi".source = ./yazi;

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
