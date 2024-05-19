{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.browser.vivaldi;
in
{
  options.plusultra.desktop.browser.vivaldi = with types; {
    enable = mkBoolOpt false "Whether to enable vivaldi browser.";
    default = mkBoolOpt false "Whether to set vivaldi as default browser.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (vivaldi.override {
        proprietaryCodecs = true;
        vivaldi-ffmpeg-codecs = vivaldi-ffmpeg-codecs;

        # enabling this segfaults vivaldi at startup
        # enableWidevine = true;
        # widevine-cdm = vivaldi-pkgs.widevine-cdm;
      })
    ];

    environment.variables = mkIf cfg.default {
      BROWSER = "vivaldi";
    };
  };
}
