{ inputs, options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.inputmethod.rime;
in
{
  options.plusultra.desktop.inputmethod.rime = with types; {
    enable = mkBoolOpt false "Whether to enable rime imputmethod.";
  };

  config = mkIf cfg.enable {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-rime
        fcitx5-nord
      ];
    };
  };
}
