{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.browser.firefox;
in
{
  options.plusultra.desktop.browser.firefox = with types; {
    enable = mkBoolOpt false "Whether to enable firefox browser.";
    pkg = mkOpt package pkgs.firefox "The terminal to install.";
    default = mkBoolOpt false "Whether to set firefox as default browser.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.pkg ];

    environment.variables = mkIf cfg.default {
      BROWSER = "firefox";
    };
  };
}
