{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.browser.chrome;
in
{
  options.plusultra.desktop.browser.chrome = with types; {
    enable = mkBoolOpt false "Whether to enable chrome browser.";
    pkg = mkOpt package pkgs.google-chrome "The terminal to install.";
    default = mkBoolOpt false "Whether to set chrome as default browser.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.pkg ];

    environment.variables = mkIf cfg.default {
      BROWSER = "google-chrome";
    };
  };
}
