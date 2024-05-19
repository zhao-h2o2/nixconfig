{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.browser.vivaldi;
in
{
  options.plusultra.desktop.browser.vivaldi = with types; {
    enable = mkBoolOpt false "Whether to enable vivaldi browser.";
    pkg = mkOpt package pkgs.vivaldi "The terminal to install.";
    default = mkBoolOpt false "Whether to set vivaldi as default browser.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.pkg ];

    environment.variables = mkIf cfg.default {
      BROWSER = "vivaldi";
    };
  };
}
