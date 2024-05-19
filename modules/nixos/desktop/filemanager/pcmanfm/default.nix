{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.filemanager.pcmanfm;
in
{
  options.plusultra.desktop.filemanager.pcmanfm = with types; {
    enable = mkBoolOpt false "Whether to enable the pcmanfm file manager.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ pcmanfm ];
  };
}
