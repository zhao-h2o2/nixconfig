{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.terminal.foot;
in
{
  options.plusultra.desktop.terminal.foot = with types; {
    enable = mkBoolOpt false "Whether to enable the gnome file manager.";
  };

  config = mkIf cfg.enable {
    plusultra.desktop.terminal = {
      enable = true;
      pkg = pkgs.foot;
    };
  };
}
