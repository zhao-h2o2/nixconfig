{ inputs, options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.rime;
in
{
  options.plusultra.apps.rime = with types; {
    enable = mkBoolOpt false "Whether to enable rime imputmethod.";
  };

  config = mkIf cfg.enable {
    home.file = {
      rime = {
        enable = true;
        target = if pkgs.stdenv.isDarwin then "Library/Rime/" else ".local/share/fcitx5/rime/";
        source = inputs.rime-ice;
        recursive = true;
      };

      rime-default = {
        enable = true;
        target = if pkgs.stdenv.isDarwin then "Library/Rime/default.custom.yaml" else ".local/share/fcitx5/rime/default.custom.yaml";
        source = ./default.custom.yaml;
      };

      rime-flypy = {
        enable = true;
        target = if pkgs.stdenv.isDarwin then "Library/Rime/double_pinyin_flypy.custom.yaml" else ".local/share/fcitx5/rime/double_pinyin_flypy.custom.yaml";
        source = ./double_pinyin_flypy.custom.yaml;
      };

      rime-squirrel = mkIf pkgs.stdenv.isDarwin {
        enable = true;
        target = "Library/Rime/squirrel.custom.yaml";
        source = ./squirrel.custom.yaml;
      };
    };
  };
}
