{ config, lib, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.nix-cache;
in
{
  options.plusultra.nix-cache = {
    enable = mkEnableOption "Plus Ultra public cache";
  };

  config = mkIf cfg.enable {
    plusultra.nix.extra-substituters = {
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store".key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
    };
  };
}
