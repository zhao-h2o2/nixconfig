{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.foot;
in
{
  options.plusultra.apps.foot = with types; {
    enable = mkBoolOpt false "Whether to enable the gnome file manager.";
  };

  config = mkIf cfg.enable {
    xdg.configFile."foot/foot.ini".source = ./foot.ini;
  };
}
