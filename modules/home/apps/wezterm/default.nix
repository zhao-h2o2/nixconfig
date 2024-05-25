{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.wezterm;
in
{
  options.plusultra.apps.wezterm = with types; {
    enable = mkBoolOpt false "Whether to enable wezterm.";
  };

  config = mkIf cfg.enable {
    xdg.configFile."wezterm".source = ./wezterm;
  };
}
