{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.terminal;
in
{
  options.plusultra.desktop.terminal = with types; {
    enable = mkBoolOpt false "Whether to enable terminal.";
    pkg = mkOpt package pkgs.foot "The terminal to install.";
  };

  config = mkIf cfg.enable { environment.systemPackages = [ cfg.pkg ]; };
}
