inputs @ {
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.apps.zotero;
in {
  options.plusultra.apps.zotero = with types; {
    enable = mkBoolOpt false "Whether or not to enable zotero.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      zotero
    ];
  };
}
