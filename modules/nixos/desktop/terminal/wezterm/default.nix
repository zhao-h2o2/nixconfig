{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.terminal.wezterm;
in
{
  options.plusultra.desktop.terminal.wezterm = with types; {
    enable = mkBoolOpt false "Whether to enable wezterm.";
  };

  config = mkIf cfg.enable {
    plusultra.desktop.terminal = {
      enable = true;
      pkg = pkgs.wezterm;
    };
  };
}
