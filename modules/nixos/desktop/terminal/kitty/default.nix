{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.terminal.kitty;
in
{
  options.plusultra.desktop.terminal.kitty = with types; {
    enable = mkBoolOpt false "Whether to enable the kitty terminal.";
  };

  config = mkIf cfg.enable {
    plusultra.desktop.terminal = {
      enable = true;
      pkg = pkgs.kitty;
    };

    plusultra.home.configFile = {
      "kitty/kitty.conf".source = ./kitty.conf;
      "kitty/scheme.conf".source = ./tokyonight.conf;
    };
  };
}
