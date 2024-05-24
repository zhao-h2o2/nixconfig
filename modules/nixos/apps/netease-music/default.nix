inputs @ {
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.apps.netease-music;
in {
  options.plusultra.apps.netease-music = with types; {
    enable = mkBoolOpt false "Whether or not to enable netease-cloud-music-gtk.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      yesplaymusic
    ];
  };
}
