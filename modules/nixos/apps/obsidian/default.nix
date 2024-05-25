inputs @ {
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.apps.obsidian;
in {
  options.plusultra.apps.obsidian = with types; {
    enable = mkBoolOpt false "Whether or not to enable obsidian-cloud-music-gtk.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  };
}
