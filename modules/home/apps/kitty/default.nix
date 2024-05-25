{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.kitty;
in
{
  options.plusultra.apps.kitty = with types; {
    enable = mkBoolOpt false "Whether to enable the kitty terminal.";
  };

  config = mkIf cfg.enable {
    xdg.configFile = {
      "kitty/kitty.conf".source = ./kitty.conf;
      "kitty/scheme.conf".source = ./nord.conf;
    };
  };
}
